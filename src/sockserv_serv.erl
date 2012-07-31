-module(sockserv_serv).
-behaviour(gen_server).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).

-define(SOCK(Msg), {tcp, _Port, Msg}).

-record(state, {socket}).

start_link(Socket) ->
    gen_server:start_link(?MODULE, Socket, []).

init(Socket) ->
    <<A:32, B:32, C:32>> = crypto:rand_bytes(12),
    random:seed({A,B,C}),
    gen_server:cast(self(), accept),
    {ok, #state{socket=Socket}}.

handle_call(_E, _From, State) ->
    {noreply, State}.

handle_cast(accept, S = #state{socket=ListenSocket}) ->
    {ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
    send(AcceptSocket, "Accepted", []),
    {noreply, S#state{socket=AcceptSocket}}.

handle_info(?SOCK("quit"++_), S) ->
    send(S#state.socket, "Quit", []),
    gen_tcp:close(S#state.socket),
    {stop, normal, S};

handle_info(?SOCK(Str), S = #state{socket=Socket}) ->
    T = line(Str),
    send(Socket, "You say: " ++ T, []),
    {noreply, S};

handle_info({tcp_closed, _}, S) ->
    {stop, normal, S};

handle_info(E, S) ->
    io:format("unexpected: ~p~n", [E]),
    {noreply, S}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(normal, _State) ->
    ok;
terminate(_Reason, _State) ->
    io:format("terminate reason: ~p~n", [_Reason]).

%% ==================
%% internal functions
%% ==================
send(Socket, Str, Args) ->
    gen_tcp:send(Socket, io_lib:format(Str++"~n", Args)),
    inet:setopts(Socket, [{active, once}]),
    ok.

line(Str) ->
    hd(string:tokens(Str, "\r\n ")).
