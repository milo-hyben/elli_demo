elli_demo
=========

Demo of Elli webserver for Sydney Erlang User Group 

Prerequisites: erlang, rebar

How to compile:

Get dependencies:

    rebar get-deps

Compile:

    rebar compile

Execute in main project folder:

    erl -pa ebin src deps/*/ebin -s elli_demo

or 

    ./start.sh


Available pages

Static content:

    http://localhost:3000/static/welcome.html

Protected - not authorised:

    http://localhost:3000/static/protected/welcome.html

Protected - authorised (Chromium syntax for passing username and password):

    admin:secret@http://localhost:3000/static/protected/welcome.html

Dynamic content handled by elli_demo_handler module:

    http://localhost:3000/hello
    http://localhost:3000/hello/world

Protected dynamic (replace * with any combination of words / path): 
    
    /protected/*

Example of elli_stats module:

    http://localhost:3000/elli/stats

Open a terminal and run ./generate.sh

It will run 6000 requests in a loop, watch browser for real-time statistics.


Cheat sheet:

Compile modified handles without restarting server:

    c("src/elli_demo_handler.erl", [{outdir,"ebin/"}]).

Debug the handler - start debugger, load demo_handler module and add break point to handle first function:

    debugger:start().
    ii(elli_demo_handler).
    ib(elli_demo_handler, handle, 2).

Enjoy!





