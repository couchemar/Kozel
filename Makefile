REBAR = ./rebar

.PHONY: clean compile run

clean:
	$(REBAR) clean

compile:
	$(REBAR) compile

run:
	make compile
	@erl -pa ebin -eval "application:start(kozel)."

tests:
	make clean
	make compile
	$(REBAR) eunit

dialyzer-all:
	make clean
	@dialyzer --src -r test/ -r src/

dialyzer:
	make clean
	@dialyzer --src -r src/