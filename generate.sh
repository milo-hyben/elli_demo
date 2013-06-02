for I in {1..1000}
do
	curl http://localhost:3000/favicon.ico
	curl http://localhost:3000/hello
    curl http://localhost:3000/hello/world
    curl http://localhost:3000/static/protected/welcome.html
    curl http://localhost:3000/static/welcome.html
    curl http://localhost:3000/snail
done
