# Traccar Web UI Mod in Docker

This is an official Docker image of [Traccar Web UI Mod](http://traccar.litvak.su/).
The image is suitable for evaluation purposes as well as for production use.

# How to use this image

You should first install [Docker](https://www.docker.com/) on your machine.

Then there are several options:

1.	Pull the traccar-web image from DockerHub.
2.	Get the [sources of this project](https://github.com/vitalidze/traccar-web-docker) and build them.

## Pulling existing image

Usually you need to run 2 containers:

-	One for the Traccar + Web UI Mod image
-	Optional database image to which Traccar Web UI Mod connects to

### Using docker-compose

For both described options logs and data reside in the same folder, where the docker-compose is located under the `logs` and `data` subfolders accordingly. The only exposed port is 8082 for HTTP access. For collecting data from devices (i.e. GPS trackers) please update the `docker-compose.yml` file to expose the necessary ports.

#### H2

There is an option to run Traccar + Web UI Mod with built-in database called H2. It is intended for testing only and it is highly NOT recommended to be used in production. Download [docker-compose.yml](https://github.com/vitalidze/traccar-web-docker/raw/master/h2/docker-compose.yml), put it some folder and run it by issuing following command:

```console
docker-compose up -d
```

#### MySQL

For production databases it is highly recommended to run a separate database server, like MySQL. Download [docker-compose.yml](https://github.com/vitalidze/traccar-web-docker/raw/master/mysql/docker-compose.yml), put it some folder and run it by issuing following command:

```console
docker-compose up -d
```