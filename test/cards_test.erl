-module(cards_test).
-include_lib("eunit/include/eunit.hrl").

compare_trumps_test_() ->
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

compare_not_trumps_test_() ->
    [?_assertEqual({{"♣", "A"}, 0, 11},
                   cards:compare({"♣", "A"}, {"♠", "10"})),
     ?_assertEqual({{"♠", "A"}, 0, 11},
                   cards:compare({"♣", "10"}, {"♠", "A"}))
    ].

compare_trumps_and_not_trumps_test_() ->
    [?_assertEqual({{"♣", "Q"}, 14, 3},
                   cards:compare({"♣", "Q"}, {"♠", "10"})),
     ?_assertEqual({{"♣", "Q"}, 14, 3},
                   cards:compare({"♠", "10"}, {"♣", "Q"}))
    ].
