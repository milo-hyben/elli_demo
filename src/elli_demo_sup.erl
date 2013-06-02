%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(elli_demo_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).


%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    FileserveConfig = [{prefix, <<"/static">>},
                     {path, <<"priv/static">>}
                    ],

    BasicauthConfig = [
                     {auth_fun, fun elli_demo_protected:auth_fun/3},
                     {auth_realm, <<"Admin Area">>} % optional
                    ],

    IdentityFun =
        fun (Req) ->
                case elli_request:path(Req) of
                    [<<"favicon.ico">>] -> <<"favicon">>;
                    [<<"hello">>] -> <<"hello">>;
                    [<<"snail">>] -> <<"long running page">>;
                    [<<"static">>, <<"protected">>, <<"welcome.html">>] -> <<"welcome admin page">>;
                    [<<"static">>, <<"welcome.html">>] -> <<"welcome page">>;
                    [<<"hello">>, <<"world">>] -> <<"hello/world">>;
                    _ -> <<"unknown">>
                end
        end,

    StatsConfig = [{name, elli_stats_demo},
                   {docroot, "priv/stats"},
                   {identity_fun, IdentityFun}],


    Config = [{mods, [
                {elli_basicauth, BasicauthConfig},
                {elli_fileserve, FileserveConfig},
                  {elli_stats, StatsConfig},
                  {elli_access_log, []},
                    {elli_demo_handler, []}
                 ]
          }],

    ElliOpts = [
                {callback, elli_middleware},
                {callback_args, Config},
                {port, 3000}
               ],
    ElliSpec = {
        elli_demo_http,
        {elli, start_link, [ElliOpts]},
        permanent,
        5000,
        worker,
        [elli]},

    {ok, { {one_for_one, 5, 10}, [ElliSpec]} }.
