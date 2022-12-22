
Tutorial url: https://youtu.be/PgHIVt_S6PE 

SonarQube docker build. (See docker-compose.yml)

## Instructions
run `docker-compose -up -d`
```
    In your browser, connect to http://127.0.0.1:9000
    Default
        Username = admin
        Password = admin
```
If you have Makefile installed, then use the command `make` to see a list of supported commands. For the most part, supported make commands are:
````
      help        Print help.
      ps          Show containers.
      build       Build all containers
      start       Start all containers
      fresh       Destroy & recreate all containers
      stop        Stop all containers
      restart     Restart all containers
      destroy     Destroy all containers
      ssh         SSH inside sonarqube container
      sonar-install  install sonarqube scanner
      sonar-scan  run sonarqube
````

To install sonar scanner on linux, you can use the provided script `./scripts/install-sonar-scanner`. Make sure you have `unzip` installed. (To install run `sudo apt-get install unzip`.

To run the scanner, you can use this sample code
````
	/var/opt/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
		-Dsonar.projectKey=JustTMS \
		-Dsonar.sources=. \
		-Dsonar.host.url=http://127.0.0.1:9000 \
		-Dsonar.login=sqp_55b0ce2c049a0b2d3d99a9e84ee06fe8a1d00c09
````
Make sure you change the projectKey and the login key above to match the provided values inside the SonarQube UI (per your project configuration).

