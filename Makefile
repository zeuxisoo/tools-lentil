@all:
	@echo "Command      : Description"
	@echo "------------ : -------------"
	@echo "make example : Run the examples/default.tin"

example:
	@node src/index.js examples/default.tin
