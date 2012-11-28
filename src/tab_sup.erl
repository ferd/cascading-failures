-module(tab_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
    {ok, {{one_for_one, 2, 10},
            [{table_serv,
                    {tab_serv, start_link, [my_table]},
                    permanent, 1000, worker, [tab_serv]}
            ]}}.
