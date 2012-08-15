-module(cards).
-include_lib("include/cards.hrl").

-export([compare/2]).

-spec compare(card(), card()) -> {card(), number(), number()}.
compare(Card1, Card2) ->
    P1 = get_power(Card1),
    P2 = get_power(Card2),

    {Card,
     Power} = if
                  P1 > P2 ->
                      {Card1, P1};
                  P2 > P1 ->
                      {Card2, P2};
                  true ->
                      {Card1, P1}
              end,
    if
        Power == 0 ->
            C1 = get_cost(Card1),
            C2 = get_cost(Card2),
            Result = if
                         C1 > C2 ->
                             {Card1, 0, C1};
                         C2 > C1 ->
                             {Card2, 0, C2};
                         true ->
                             {Card1, 0, C1}
                     end;
        true ->
            Cost = get_cost(Card),
            Result = {Card, Power, Cost}
    end,
    Result.
-spec get_power(card()) -> card_power().
get_power(Card) ->
    proplists:get_value(Card, ?TRUMPS_POWER, 0).

-spec get_cost(card()) -> card_cost().
get_cost({_Suite, CardName}) ->
    proplists:get_value(CardName, ?CARDS_COST, 0).
