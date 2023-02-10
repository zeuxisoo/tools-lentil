module ast

import ast.expressions { Expression }
import ast.statements { Statement }

pub type Node = Statement | Expression
