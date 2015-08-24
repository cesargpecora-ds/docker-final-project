docker build -t docker-excercise:1.0 .
docker run --name mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=homestead -e MYSQL_USER=homestead -e MYSQL_PASSWORD=secret -d mysql:5.6
docker run --name web --link mysql:mysql -d -p 80:80 -v ./worldapi:/opt/www/worldapi docker-excercise:1.0
