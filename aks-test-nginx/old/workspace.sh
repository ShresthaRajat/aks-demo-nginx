docker build -t simple-nginx .
docker run --rm -it -p 8080:80 simple-nginx