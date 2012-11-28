-module(work_sup).
-behaviour(supervisor).

-export([start_link/1]).
-export([init/1]).

start_link(Num) ->
    supervisor:start_link({local,?MODULE}, ?MODULE, Num).

init(Num) ->
    TabName = my_table,
    spawn(fun() -> spawn_workers(Num) end),
    {ok, {{simple_one_for_one, Num*10, 1},
            [{worker,
                    {worker, start_link, [TabName]},
                    permanent, 1000, worker, [worker]}
            ]}}.

spawn_workers(0) -> ok;
spawn_workers(N) ->
    supervisor:start_child(?MODULE, []),
    spawn_workers(N-1).
