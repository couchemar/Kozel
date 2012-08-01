.PHONY: clean compile run

clean:
	@rebar clean

compile:
	@rebar compile

run:
	make compile
	@erl -pa ebin -eval "application:start(kozel)."

tests:
	make clean
	make compile
	@rebar eunit
