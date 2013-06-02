%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(elli_demo_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_Type, _Args) ->
  elli_demo_sup:start_link().


stop(_State) ->
    ok.



