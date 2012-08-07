-module(cards).
-include_lib("include/cards.hrl").

-export([compare/2]).

compare(Card1, Card2) ->
    P1 = get_power(Card1),
    P2 = get_power(Card2),

    C1 = get_cost(Card1),
    C2 = get_cost(Card2),
    % Возвращаем {Card, Power, Cost}
    {Card1, P1, C1}.

get_power(_) ->
    0.

get_cost(_) ->
    0.
