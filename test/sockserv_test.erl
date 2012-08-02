-module(sockserv_test).
-include_lib("eunit/include/eunit.hrl").

sockserv_test_() ->
    {setup,
     fun start/0,
     fun stop/1,
     fun connect_test/1}.

start() ->
    Port = 9999,
    {ok, Socket} = gen_tcp:listen(Port,
                                  [{active, once},
                                   {packet, line}]),
    {ok, _Pid} = sockserv_serv:start_link(Socket),
    {Socket, Port}.

stop({Socket, _Port}) ->
    gen_tcp:close(Socket).

connect_test({_Socket, Port}) ->
    {ok, Socket} = gen_tcp:connect({127, 0, 0, 1}, Port, []),
    Res = receive_data(),
    ok = gen_tcp:send(Socket, "Test\n"),
    Res1 = receive_data(),
    [?_assertEqual("Accepted\n", Res),
     ?_assertEqual("You say: Test\n", Res1)
    ].

receive_data() ->
    receive
        {tcp, _, R} -> Res = R
    end,
    Res.

