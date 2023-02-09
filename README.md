# Flask-App-Alpine

This is a basic Flask application that serves a simple static website that returns the machine's hostname.

It is directly accessible on port 80 by running the commands:

docker build -t flask-app-alpine .
docker run -d -p 80:5500 --name f-app-alpine flask-app-alpine
This is an example of a container built with minimal unnecessary files.
