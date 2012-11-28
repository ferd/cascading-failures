-module(crashapp_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_, _) ->
	top_sup:start_link().

stop(_) ->
	ok.
