%% @author milo.hyben@gmail.com
%% @doc @todo Add description

-module(elli_demo_protected).

%% ====================================================================
%% API functions
%% ====================================================================
-export([auth_fun/3]).

%% ====================================================================
%% Internal functions
%% ====================================================================

auth_fun(Req, User, Password) ->
    case elli_request:path(Req) of
        [<<"static">>, <<"protected">> | T] -> password_check(User, Password);
        [<<"protected">> | T] -> password_check(User, Password);
        _                 -> ok
    end.

password_check(User, Password) ->
    case {User, Password} of
        {undefined, undefined}      -> unauthorized;
        {<<"admin">>, <<"secret">>} -> ok;
        {User, Password}            -> forbidden
    end.

