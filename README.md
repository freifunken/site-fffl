## Dependencies
Arch Linux/Manjaro
```sh
# rank mirrors by speed and filter the out of date ones
sudo pacman-mirrors -g
# synchronize repo databases and update your system
sudo pacman -Syyu
# install package group for development purposes
sudo pacman -S base-devel
```

## Building the images
```sh
# Arch Linux/Manjaro
sudo pacman -Syyu

# Debian
sudo aptitude full-upgrade
```

```sh
git clone https://github.com/freifunk-gluon/gluon.git gluon -b v2016.1.x
cd gluon
git clone https://github.com/freifunken/site-fffl.git site -b l2tp-v2016.1.x
```

```sh
make GLUON_TARGET=?
```

```sh
make update
make clean GLUON_TARGET=ar71xx-generic
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental BROKEN=1
```
If the build fails, even after some retries,
slow down and simplify the task:
```sh
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```
```sh
make V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```

## Misc
Prevent shitty #clownflare from stopping your build due to broken downloads:
* https://github.com/apenwarr/sshuttle
  * https://blog.marco-ilgner.de/article/vpn-im-uberspace (**Outdated!**)

## Resources
* http://gluon.readthedocs.io/en/latest/user/getting_started.html
