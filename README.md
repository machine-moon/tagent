use this to get your docker image as when u login with google itll redirr you to localhost:34117

replace localhost with this ip for the callback url to work:
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gemini-agent

