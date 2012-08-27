% Cards definition

-type suit() :: clubs | spades | hearts | diamonds.
-type value() :: 7..10 | j | q | k | a.
-type card() :: {suit(), value()}.

-type card_cost() :: 0 | 2..4 | 10 | 11.
-type card_power() :: 0..14.


-define(SUIT_SYMBOLS, [{clubs, "♣"},
                       {spades, "♠"},
                       {hearts, "♥"},
                       {diamonds, "♦"}]).

-define(CARDS_COST, [{a, 11},
                     {k, 4},
                     {q, 3},
                     {j, 2},
                     {10, 10},
                     {9, 0},
                     {8, 0},
                     {7, 0}
                    ]).

-define(TRUMPS_POWER, [%% QUEENS
                       {{clubs, q}, 14},
                       {{spades, q}, 13},
                       {{hearts, q}, 12},
                       {{diamonds, q}, 11},
                       %% JACKS
                       {{clubs, j}, 10},
                       {{spades, j}, 9},
                       {{hearts, j}, 8},
                       {{diamonds, j}, 7},
                       %% Rest Trumps
                       {{diamonds, a}, 6},
                       {{diamonds, 10}, 5},
                       {{diamonds, k}, 4},
                       {{diamonds, 9}, 3},
                       {{diamonds, 8}, 2},
                       {{diamonds, 7}, 1}
                      ]).
