-module(crashapp).
-export([start/0]).

start() ->
	application:start(crashapp).
