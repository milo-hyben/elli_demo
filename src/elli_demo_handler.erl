%% @author milo.hyben@gmail.com
%% @doc @todo Add description to resource_handler.

-module(elli_demo_handler).

-include_lib("elli/include/elli.hrl").
-behaviour(elli_handler).

%% ====================================================================
%% API functions
%% ====================================================================
-export([handle/2, handle_event/3
		, handle/3
		]).

%% ====================================================================
%% Internal functions
%% ====================================================================


handle(Req, _Args) ->
    %% Delegate to our handler function
    handle(Req#req.method, elli_request:path(Req), Req).

handle('GET',[<<"protected">> | T], _Req) ->
    %% Reply with a normal response. 'ok' can be used instead of '200'
    %% to signal success.
    Prefix = bjoin([<<"Admin Area" >> | T]),
    %%{ok, [], <<Prefix/binary, T/binary>>};
    {ok, [], Prefix};

handle('GET',[<<"hello">>, <<"world">>], _Req) ->
    %% Reply with a normal response. 'ok' can be used instead of '200'
    %% to signal success.
    {ok, [], <<"Hello World!">>};

handle('GET',[<<"hello">>], _Req) ->
    %% Reply with a normal response. 'ok' can be used instead of '200'
    %% to signal success.
    {ok, [], <<"Hello!">>};

handle('GET',[<<"favicon.ico">>], _Req) ->
    %% Reply with a normal response. 'ok' can be used instead of '200'
    %% to signal success.
    {ok, [], <<"favicon.ico">>};
    
handle('GET',[<<"snail">>], _Req) ->
    %% Reply with a normal response. 'ok' can be used instead of '200'
    %% to signal success.
    timer:sleep(50),
    {ok, [], <<"Sooooo Slooooow!">>};


handle('POST', Resource, Req) ->
    %% Fetch a POST argument from the POST body.
    B=Req#req.body,
    %%Name = elli_request:post_arg(<<"name">>, Req, <<"undefined">>),
    {ok, [], <<"Hello ", B/binary>>};

handle(_, _, _Req) ->
    {404, [], <<"Not Found">>}.

%% @doc: Handle request events, like request completed, exception
%% thrown, client timeout, etc. Must return 'ok'.
handle_event(_Event, _Data, _Args) ->
    ok.

bjoin(List) ->
    F = fun(A, B) -> <<A/binary, " / ", B/binary>> end,
    lists:foldr(F, <<>>, List).
