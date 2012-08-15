-module(cards_test).
-include_lib("eunit/include/eunit.hrl").

compare_trumps_test_() ->
    CLUBS_Q = {{clubs, q}, 14, 3},
    [?_assertEqual(CLUBS_Q,
                   cards:compare({clubs, q}, {spades, q})),
     ?_assertEqual(CLUBS_Q,
                   cards:compare({clubs, q}, {hearts, q})),
     ?_assertEqual(CLUBS_Q,
                   cards:compare({clubs, q}, {diamonds, q})),
     ?_assertEqual(CLUBS_Q,
                   cards:compare({spades, q}, {clubs, q})),
     ?_assertEqual(CLUBS_Q,
                   cards:compare({hearts, q}, {clubs, q})),
     ?_assertEqual(CLUBS_Q,
                   cards:compare({diamonds, q}, {clubs, q}))
    ].

compare_not_trumps_test_() ->
    [?_assertEqual({{clubs, a}, 0, 11},
                   cards:compare({clubs, a}, {spades, 10})),
     ?_assertEqual({{spades, a}, 0, 11},
                   cards:compare({clubs, 10}, {spades, a})),
     ?_assertEqual({{clubs, a}, 0, 11},
                   cards:compare({clubs, a}, {spades, a}))
    ].

compare_trumps_and_not_trumps_test_() ->
    [?_assertEqual({{clubs, q}, 14, 3},
                   cards:compare({clubs, q}, {clubs, 10})),
     ?_assertEqual({{clubs, q}, 14, 3},
                   cards:compare({clubs, 10}, {clubs, q}))
    ].

