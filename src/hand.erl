%%%-------------------------------------------------------------------
%%% @author Andrey Pavlov <couchemar@couchemar>
%%% @copyright (C) 2012, Andrey Pavlov
%%% @doc
%%% State-machine отвечающий за состояние "руки" игрока.
%%% @end
%%% Created : 28 Aug 2012 by Andrey Pavlov <couchemar@couchemar>
%%%-------------------------------------------------------------------
-module(hand).

-behaviour(gen_fsm).

-include_lib("include/cards.hrl").

%% API
-export([start_link/1]).

%% gen_fsm callbacks
-export([init/1, handle_event/3,
         handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).

-export([idle/2, idle/3, turn/2, turn/3]).

-define(SERVER, ?MODULE).

-record(state, {cards}).

%%%===================================================================
%%% API
%%%===================================================================
-spec start_link([card()]) -> {ok, pid()}     |
                              ignore          |
                              {error, term()}.
start_link(Cards) ->
    gen_fsm:start_link(?MODULE, Cards, []).

%%%===================================================================
%%% gen_fsm callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a gen_fsm is started using gen_fsm:start/[3,4] or
%% gen_fsm:start_link/[3,4], this function is called by the new
%% process to initialize.
%%
%% @spec init(Args) -> {ok, StateName, State} |
%%                     {ok, StateName, State, Timeout} |
%%                     ignore |
%%                     {stop, StopReason}
%% @end
%%--------------------------------------------------------------------
init(Cards) ->
    {ok, idle, #state{cards=sets:from_list(Cards)}}.

idle(_Event, State) ->
    {stop, bad_event, State}.

turn(_Event, State) ->
    {stop, bad_event, State}.

idle(your_turn, _From, State) ->
    {reply, ok, turn, State}.

turn({go, Card}, _From, State) ->
    Cards = State#state.cards,
    case sets:is_element(Card, Cards) of
        true ->
            NewCards = sets:del_element(Card, Cards),
            NewState = State#state{cards=NewCards},
            {reply, ok, idle, NewState};
        false -> {reply, 'bad card', turn, State}
    end.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a gen_fsm receives an event sent using
%% gen_fsm:send_all_state_event/2, this function is called to handle
%% the event.
%%
%% @spec handle_event(Event, StateName, State) ->
%%                   {next_state, NextStateName, NextState} |
%%                   {next_state, NextStateName, NextState, Timeout} |
%%                   {stop, Reason, NewState}
%% @end
%%--------------------------------------------------------------------
handle_event(_Event, StateName, State) ->
    {next_state, StateName, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a gen_fsm receives an event sent using
%% gen_fsm:sync_send_all_state_event/[2,3], this function is called
%% to handle the event.
%%
%% @spec handle_sync_event(Event, From, StateName, State) ->
%%                   {next_state, NextStateName, NextState} |
%%                   {next_state, NextStateName, NextState, Timeout} |
%%                   {reply, Reply, NextStateName, NextState} |
%%                   {reply, Reply, NextStateName, NextState, Timeout} |
%%                   {stop, Reason, NewState} |
%%                   {stop, Reason, Reply, NewState}
%% @end
%%--------------------------------------------------------------------
handle_sync_event('state?', _From, StateName, State) ->
    Reply = {StateName, sets:to_list(State#state.cards)},
    {reply, Reply, StateName, State};
handle_sync_event(_Event, _From, StateName, State) ->
    Reply = ok,
    {reply, Reply, StateName, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_fsm when it receives any
%% message other than a synchronous or asynchronous event
%% (or a system message).
%%
%% @spec handle_info(Info,StateName,State)->
%%                   {next_state, NextStateName, NextState} |
%%                   {next_state, NextStateName, NextState, Timeout} |
%%                   {stop, Reason, NewState}
%% @end
%%--------------------------------------------------------------------
handle_info(_Info, StateName, State) ->
    {next_state, StateName, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_fsm when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_fsm terminates with
%% Reason. The return value is ignored.
%%
%% @spec terminate(Reason, StateName, State) -> void()
%% @end
%%--------------------------------------------------------------------
terminate(_Reason, _StateName, _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, StateName, State, Extra) ->
%%                   {ok, StateName, NewState}
%% @end
%%--------------------------------------------------------------------
code_change(_OldVsn, StateName, State, _Extra) ->
    {ok, StateName, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
