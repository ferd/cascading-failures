-module(tab_serv).
-compile(export_all).
-behaviour(gen_server).

start_link(TabName) ->
    gen_server:start_link(?MODULE, TabName, []).

init(Tab) ->
    Tid = ets:new(Tab, [named_table, public, set, {read_concurrency, true}]),
    {ok, Tid, 10000}.

handle_call(_, _, State) ->
    {noreply, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(timeout, _State) ->
    exit(self(), some_error).

code_change(_Vsn, State, _Extra) ->
    {ok, State}.

terminate(_, _) ->
    ok.

