-module(cards_test).
-include_lib("eunit/include/eunit.hrl").

compare_test_() ->
    [?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♣", "Q"}, {"♠", "Q"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♣", "Q"}, {"♥", "Q"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♣", "Q"}, {"♦", "Q"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♠", "Q"}, {"♣", "Q"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♥", "Q"}, {"♣", "Q"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                  cards:compare({"♦", "Q"}, {"♣", "Q"}))
    ].
