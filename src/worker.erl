-module(worker).
-compile(export_all).
-behaviour(gen_server).
-record(state, {tab, ct=0}).


start_link(Tab) ->
    gen_server:start_link(?MODULE, Tab, []).

init(Tab) ->
    {ok, #state{tab=Tab},1}.

handle_call(_, _, State) ->
    {noreply, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(timeout, S=#state{tab=T, ct=Ct}) ->
    case ets:lookup(T, Ct) of
        [] -> {noreply, S#state{ct=Ct+1},1};
        [_|_] -> {noreply, S#state{ct=Ct-1},1}
    end.

code_change(_Vsn, State, _Extra) ->
    {ok, State}.

terminate(_, _) ->
    ok.
