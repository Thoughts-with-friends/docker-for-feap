# Dockerized FEAPpv

[FEAPpv]is a general-purpose educational finite element code
(a light-weight version of [FEAP]).  This repository describes
a [Docker] container for [FEAPpv].

Note that [FEAPpv] does have an X11-based graphics module, but
it is not so simple to connect to an X11 server from a container.

The image can be retrieved from DockerHub via

    docker pull dbindel/feappv-dev


[FEAPpv]: http://www.ce.berkeley.edu/projects/feap/feappv/
[FEAP]:   http://www.ce.berkeley.edu/projects/feap/
[Docker]: https://www.docker.com/
