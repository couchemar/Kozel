% Cards definition

-type suit() :: spades | clubs | hearts | diamonds.
-type value() :: 7..10 | j | q | k | a.
-type card() :: {suit(), value()}.

-define(SUIT_SYMBOLS, [{clubs, "♣"},
                       {spades, "♠"},
                       {hearts, "♥"},
                       {diamonds, "♦"}]).

-define(CARDS_COST, [{"A", 11},
                     {"K", 4},
                     {"Q", 3},
                     {"J", 2},
                     {"10", 10},
                     {"9", 0},
                     {"8", 0},
                     {"7", 0},
                     {"6", 0}]).

-define(TRUMPS, [
                 %% QUEENS
                 {{"♣", "Q"}, 14},
                 {{"♠", "Q"}, 13},
                 {{"♥", "Q"}, 12},
                 {{"♦", "Q"}, 11},
                 %% JACKS
                 {{"♣", "J"}, 10},
                 {{"♠", "J"}, 9},
                 {{"♥", "J"}, 8},
                 {{"♦", "J"}, 7},
                 %% Rest Trumps
                 {{"♦", "A"}, 6},
                 {{"♦", "10"}, 5},
                 {{"♦", "K"}, 4},
                 {{"♦", "9"}, 3},
                 {{"♦", "8"}, 2},
                 {{"♦", "7"}, 1}
                ]).
