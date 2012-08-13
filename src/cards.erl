-module(cards).
-include_lib("include/cards.hrl").

-export([compare/2]).

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

    Cost = get_cost(Card),
    % Возвращаем {Card, Power, Cost}
    {Card, Power, Cost}.

get_power(Card) ->
    proplists:get_value(Card, ?TRUMPS, 0).

get_cost({_Suite, CardName}) ->
    proplists:get_value(CardName, ?CARDS_COST, 0).
