#!/bin/bash

<< task
Deploy Django app
and handle the code for errors
task

code_clone() {
	echo "Cloning the Django app..."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirenments() {
	echo "Installing dependencies"
	sudo apt-get update && sudo apt-get install -y docker.io nginx docker-compose
}

required_restarts() {
	sudo chown $USER /var/run/docker.sock
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	#sudo systemctl restart docker
}

deploy() {
	docker build -t notes-app .
	docker-compose up -d
	#docker run -d -p 8000:8000 notes-app:latest
}

echo "************ DEPLOYMENT START ************"

if ! code_clone; then
	echo "The code directory already exists"
	cd django-notes-app
fi

if ! install_requirenments; then
	echo "Installation failed"
	exit 1
fi

if ! required_restarts; then
	echo "System fault identified"
	exit 1
fi

if ! deploy; then
	echo "Deployment failed, mailing the admin"
	# sendmail
	exit 1
fi

echo "************ DEPLOYMENT DONE ************"
