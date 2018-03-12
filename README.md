# matlab-support
Docker image with enough dependencies to support a mounted-in Matlab.

This docker image, based on that of [Benjamin Heasly](https://github.com/benjamin-heasly/matlab-support/) gives you an Ubuntu
environment capable of supporting Matlab. You must already have your own Matlab installed on the Docker host, which has to be on
Linux.

To run Matlab inside the container, we have to convince it that it has the same MAC address as the host machine
for which it's licensed. Then we can mount the matlab distribution on the container as a Docker volume. The script "run.sh"
will do all of this. The image is now based on Ubuntu Xenial, and comes with an Oracle JRE, thanks to
[mlaccetti](https://hub.docker.com/r/mlaccetti/docker-oracle-java8-ubuntu-16.04/)

By default, "run.sh" will launch Matlab with the "-nodesktop" option. 

Any argument passed to run.sh will be passed to matlab.


