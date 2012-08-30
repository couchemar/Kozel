-module(hands).
-include_lib("eunit/include/eunit.hrl").

hands_test_() ->
    {setup,
     fun start/0,
     fun stop/1,
     fun hand_test/1}.

start() ->
    ok.

stop(_) ->
    ok.

hand_test(_) ->
    ok.
