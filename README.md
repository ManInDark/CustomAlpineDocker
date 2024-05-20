# Contents

The Container extends the functionality of the base alpine image by adding support for services and automatically setting up the ssh config to prevent the known_hosts from overflowing & adding ssh keys for authentication. It also provides an init system that takes care of zombie processes.

# Building

It is recommended to build it yourself if unauthorized actors are able to reach the ssh port, as it would be possible to login with the committed keys.

To build it yourself, you first need to create your own pair of keys:

    cd ca-cert
    ./genca.sh

Then you can build your own image:

    docker build -t ghcr.io/manindark/customalpinedocker .

*it is not necessary to use the same tag as the one on github does, but then you won't need to replace anything in your configs, since the docker image is still "the same"
