-module(hands_tests).
-include_lib("eunit/include/eunit.hrl").

hands_test() ->
    QClubs = {clubs, q},
    QHearts = {hearts, q},
    Hand1 = [QClubs, {spades, a}],
    Hand2 = [{hearts, q}, {diamonds, j}],
    {ok, Hand1Pid} = hands:start_link(Hand1),
    {ok, Hand2Pid} = hands:start_link(Hand2),
    ?assertEqual(
       {idle, Hand1},
       gen_fsm:sync_send_all_state_event(Hand1Pid, 'state?')
      ),
    ?assertEqual(
       {idle, Hand2},
       gen_fsm:sync_send_all_state_event(Hand2Pid, 'state?')
      ),
    ?assertEqual(
       ok, gen_fsm:sync_send_event(Hand1Pid, your_turn)
      ),
    ?assertEqual(
       {turn, Hand1},
       gen_fsm:sync_send_all_state_event(Hand1Pid, 'state?')
      ),
    ?assertEqual(
       'bad card', gen_fsm:sync_send_event(Hand1Pid, {go, QHearts})
      ),
    ?assertEqual(
       {turn, Hand1},
       gen_fsm:sync_send_all_state_event(Hand1Pid, 'state?')
      ),
    ?assertEqual(
       ok, gen_fsm:sync_send_event(Hand1Pid, {go, QClubs})
      ),
    ?assertEqual(
       {idle, [{spades, a}]},
       gen_fsm:sync_send_all_state_event(Hand1Pid, 'state?')
      ).
