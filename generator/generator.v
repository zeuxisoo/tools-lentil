module generator

// vfmt off
import os
import arrays
import regex
import ast { Node, Program }
import ast.statements {
	ConfigBlockStatement, ConfigStatement,
	DateBlockStatement, DateStatement,
	ExpressionStatement, IncludeStatement
}
import ast.expressions {
	AccountExpression, AtomExpression, AmountExpression, AmountsExpression,
	DateRecordExpression, DateRecordReceiptExpression, DateRecordsExpression,
	IdentifierExpression, StringExpression, ArrayExpression, AssignExpression,
	NumberExpression, NumberKindExpression
}
import lexer
import parser
import utils { Environment, EnvironmentConfigType, EnvironmentVariableType }

type ProduceMapValue = []map[string]ProduceMapValue
	| bool
	| int
	| string

type ProduceType = []map[string]ProduceMapValue
	| map[string]ProduceMapValue
	| []string
	| string
// vfmt on

struct Generator {
mut:
	parser parser.Parser
}

pub fn new_generator(mut parser parser.Parser) &Generator {
	return &Generator{
		parser: parser
	}
}

pub fn (mut g Generator) generate() !string {
	ast_file := g.parser.parse() or {
		return err
	}

	mut environment := Environment{}
	environment.add_program('root', ast_file.root)

	result := g.produce(ast_file.ast, mut environment) or {
		return err
	} as []string

	return result.join('\n')
}

fn (mut g Generator) produce(node Node, mut environment Environment) !ProduceType {
	return match node {
		Program {
			mut codes := []string{}

			for statement in node.statements {
				code := g.produce(statement as Node, mut environment)!

				if code is string {
					if code.len > 0 {
						codes << code
					}
				}
			}

			codes
		}
		StringExpression, IdentifierExpression, AccountExpression, AtomExpression, NumberKindExpression {
			node.value
		}
		IncludeStatement {
			file_path := g.produce(node.path as Node, mut environment)!
			full_path := os.join_path_single(environment.programs['root'], file_path as string)

			mut lexer := lexer.new_lexer(full_path) or { panic(err) }
			mut parser := parser.new_parser(mut lexer)

			ast_file := parser.parse() or { panic(err) }

			g.produce(ast_file.ast, mut environment)!
		}
		ConfigStatement {
			g.produce(node.block as Node, mut environment)!
		}
		ConfigBlockStatement {
			for value in node.values {
				if value is ExpressionStatement {
					expression := value.expression

					if expression is AssignExpression {
						name := g.produce(expression.left as Node, mut environment)! as string
						data := g.produce(expression.right as Node, mut environment)!

						if data is []string {
							environment.add_config(name, EnvironmentConfigType(data))
						}
					}
				}
			}

			''
		}
		DateStatement {
			date := node.value
			rows := g.produce(node.block as Node, mut environment)! as []map[string]ProduceMapValue

			escape_quote := fn (value string) string {
				return value.replace('"', '\\"')
			}

			mut contents := []string{}

			for row in rows {
				title := escape_quote(row['title'] or { '' } as string)
				description := escape_quote(row['description'] or { '' } as string)

				contents << '${date} * "${title}" "${description}"'

				contents << g.generate_date(row)
			}

			contents.join('\n')
		}
		DateBlockStatement {
			g.produce(node.value as Node, mut environment)!
		}
		DateRecordsExpression {
			mut records := []map[string]ProduceMapValue{}

			for value in node.values {
				record := g.produce(value as Node, mut environment)!

				records << record as map[string]ProduceMapValue
			}

			records
		}
		DateRecordExpression {
			mut receipts := []map[string]ProduceMapValue{}

			for value in node.values {
				receipt := g.produce(value as Node, mut environment)!

				receipts << receipt as map[string]ProduceMapValue
			}

			title := g.produce(node.title as Node, mut environment)! as string
			description := g.produce(node.description as Node, mut environment)! as string

			mut records := map[string]ProduceMapValue{}
			records['title'] = title
			records['description'] = description
			records['receipts'] = receipts

			records
		}
		DateRecordReceiptExpression {
			account_name := g.produce(node.account as Node, mut environment)! as string
			account_value := environment.variables[account_name] or {
				return error('generator: account name not found, got `${account_name}`')
			} as string

			// find longest account to calculate whitespace between account and currency
			longest_account := arrays.reduce(
				environment.variables.values(),
				fn (a EnvironmentVariableType, b EnvironmentVariableType) EnvironmentVariableType {
					a_value := a as string
					b_value := b as string

					if a_value.len > b_value.len {
						return a
					} else {
						return b
					}
				}
			) or {
				return error('generator: cannot found max length account in environment variable table')
			}

			whitespace_length := (longest_account as string).len - account_value.len + 4

			// find manually input amount
			amounts := node.amounts

			mut amount := []map[string]ProduceMapValue{}

			if amounts is AmountsExpression {
				if amounts.values.len > 0 {
					amount = g.produce(amounts, mut environment)! as []map[string]ProduceMapValue
				}
			}else{
				return error('generator: expected amount expression, but got `${amounts}`')
			}

			// return ProduceType
			mut receipts := map[string]ProduceMapValue{}
			receipts['account'] = account_value
			receipts['amount'] = amount
			receipts['is_last'] = node.is_last
			receipts['whitespace'] = whitespace_length

			receipts
		}
		ExpressionStatement {
			g.produce(node.expression as Node, mut environment)!
		}
		ArrayExpression {
			mut items := []string{}

			for value in node.values {
				items << g.produce(value as Node, mut environment)! as string
			}

			items
		}
		AssignExpression {
			name := g.produce(node.left as Node, mut environment)! as string
			data := g.produce(node.right as Node, mut environment)!

			if data is string {
				environment.add_variable(name, EnvironmentVariableType(data))
			}

			''
		}
		AmountsExpression {
			mut amounts := []map[string]ProduceMapValue{}

			for amount in node.values {
				amounts << g.produce(amount as Node, mut environment)! as map[string]ProduceMapValue
			}

			amounts
		}
		AmountExpression {
			price := g.produce(node.value as Node, mut environment)! as string
			currency := g.produce(node.currency as Node, mut environment)! as string

			mut amount := map[string]ProduceMapValue{}
			amount['price'] = price
			amount['currency'] = currency

			amount
		}
		NumberExpression {
			kind := g.produce(node.kind as Node, mut environment)! as string
			value := node.value

			'${kind}${value}'
		}
		else {
			return error('generator: unknown node: ${node}')
		}
	}
}

fn (mut g Generator) generate_date(record_row map[string]ProduceMapValue) string {
	mut remain_amount := map[string]ProduceMapValue{}
	remain_amount['price'] = '0.00'
	remain_amount['currency'] = ''

	receipts := record_row['receipts'] or { []map[string]ProduceMapValue{} } as []map[string]ProduceMapValue

	// create structure
	mut records := []map[string]ProduceMapValue{}

	for receipt in receipts {
		receipt_is_last := receipt['is_last'] or { false } as bool

		mut receipt_amount := receipt['amount'] or { []map[string]ProduceMapValue{} } as []map[string]ProduceMapValue

		amount := if receipt_is_last {
			g.generate_remain_amount(mut receipt_amount, mut remain_amount)
		} else {
			g.generate_amount(mut receipt_amount, mut remain_amount)
		}

		mut record := map[string]ProduceMapValue{}
		record['prefix'] = ' '.repeat(4)
		record['account'] = receipt['account'] or { '' } as string
		record['account_suffix'] = ' '.repeat(receipt['whitespace'] or { 0 } as int)
		record['amount'] = amount
		record['is_last'] = receipt_is_last

		records << record
	}

	// render structure
	last_amount_length := (records.last()['amount'] or { '' } as string).len

	mut output := []string{}
	mut pattern := regex.regex_opt(r'^[+|\-][0-9]+\.[0-9]{2}\s[a-z]{3}') or { panic(err) }

	for record in records {
		output << record['prefix'] or { '' } as string
		output << record['account'] or { '' } as string
		output << record['account_suffix'] or { '' } as string

		// find first amount length `+10.00 usd @@ +7.80 xyz` -> `+10.00 usd`.length
		amount := (record['amount'] or { '' } as string)
		amount_start, amount_end := pattern.match_string(amount)

		is_last := record['is_last'] or { false } as bool

		amount_length := amount[amount_start..amount_end].len
		amount_prefix := if is_last { 0 } else { last_amount_length - amount_length }

		output << ' '.repeat(amount_prefix)
		output << record['amount'] or { '' } as string
		output << '\n'
	}

	return output.join('')
}

fn (mut g Generator) generate_remain_amount(mut amount []map[string]ProduceMapValue, mut remain_amount map[string]ProduceMapValue) string {
	// in the last record and amount is empty will auto calculated remain amount
	if amount.len <= 0 {
		remain_amount_price := (remain_amount['price'] or { '0.00' } as string).f32()

		// when remain amount is positive, it should be add `-` prefix
		if remain_amount_price > 0 {
			remain_amount['price'] = '-${remain_amount_price:0.2f}'
		}

		return g.concat_amount(mut remain_amount)
	} else {
		return g.concat_amount(mut amount[0])
	}
}

fn (mut g Generator) generate_amount(mut amount []map[string]ProduceMapValue, mut remain_amount map[string]ProduceMapValue) string {
	if amount.len == 1 {
		remain_amount = g.update_remain_amount(mut remain_amount, amount[0])

		return g.concat_amount(mut amount[0])
	}

	if amount.len == 2 {
		remain_amount = g.update_remain_amount(mut remain_amount, amount[1])

		first := g.concat_amount(mut amount[0])
		second := g.concat_amount(mut amount[1])

		return '${first} @@ ${second}'
	}

	return ''
}

fn (mut g Generator) concat_amount(mut amount map[string]ProduceMapValue) string {
	amount_price := (amount['price'] or { '0.00' } as string).f32()
	amount_currency := amount['currency'] or { '' } as string

	if amount_price >= 0 {
		amount['price'] = '+${amount_price:0.2f}'
	} else {
		amount['price'] = '${amount_price:0.2f}'
	}

	final_amount_price := amount['price'] or { '0.00' } as string

	return '${final_amount_price} ${amount_currency}'
}

fn (mut g Generator) update_remain_amount(mut remain_amount map[string]ProduceMapValue, amount map[string]ProduceMapValue) map[string]ProduceMapValue {
	amount_price := (amount['price'] or { '0.00' } as string).f32()
	remain_amount_price := (remain_amount['price'] or { '0.00' } as string).f32()

	remain_amount['price'] = (remain_amount_price + amount_price).str()
	remain_amount['currency'] = amount['currency'] or { 'unknown' }

	return remain_amount
}
