
start_nginx:
	sudo systemctl start nginx

reload_nginx:
	sudo nginx -s reload

reset_nginx_to_ubuntu_default:
	sudo cp ./nginx/ubunbtu-default.nginx.conf /etc/nginx/nginx.conf
	sudo nginx -s reload

DOCKER_CMD=docker build . --tag=python-http-server$${PORT} --build-arg PORT && docker run --publish $${PORT}:$${PORT} --name python-http-server$${PORT} --detach python-http-server$${PORT}:latest
start_httpservers:
	export PORT=2222; $(DOCKER_CMD);
	export PORT=3333; $(DOCKER_CMD);
	export PORT=4444; $(DOCKER_CMD);
	export PORT=5555; $(DOCKER_CMD);

stop_httpservers:
	docker stop python-http-server2222:latest
	docker stop python-http-server3333:latest
	docker stop python-http-server4444:latest
	docker stop python-http-server5555:latest
