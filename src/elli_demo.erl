%% @author Milo Hyben <milo.hyben@gmail.com>
%% @copyright 2013 Milo Hyben

%% @doc elli_demo startup code

-module(elli_demo).
-author('Milo Hyben <milo.hyben@gmail.com>').

-export([start/0, start_link/0, stop/0]).

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
  start_common(),
  elli_demo_sup:start_link().

%% @spec start() -> ok
%% @doc Start the elli_demo server.
start() ->
  start_common(),
  application:start(elli_demo).

%% @spec stop() -> ok
%% @doc Stop the elli_demo server.
stop() ->
  Res = application:stop(elli_demo),

  application:stop(elli_access_log),
  application:stop(elli_stats),
  application:stop(elli_basicauth),
  application:stop(elli_fileserve),
  application:stop(elli),
  application:stop(ibrowse),
  application:stop(inets),
  application:stop(ssl),
  application:stop(public_key),
  application:stop(crypto),
  Res.

start_common() ->
  ensure_started(crypto),
  ensure_started(public_key),
  ensure_started(ssl),
  ensure_started(inets),
  ensure_started(ibrowse),
  ensure_started(elli),
  ensure_started(elli_fileserve),
  ensure_started(elli_basicauth),
  ensure_started(elli_stats),
  ensure_started(elli_access_log),

  ok.

ensure_started(App) ->
  case application:start(App) of
      ok ->
          ok;
      {error, {already_started, App}} ->
          ok
  end.


