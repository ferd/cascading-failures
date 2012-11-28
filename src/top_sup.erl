-module(top_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
    {ok, {{one_for_one, 200, 10},
            [{work_sup,
                    {work_sup, start_link, [10000]},
                    permanent, 1000, supervisor, [work_sup]},
             {tab_sup,
                    {tab_sup, start_link, []},
                    permanent, 1000, supervisor, [tab_sup]}
            ]}}.

