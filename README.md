## Dependencies
Arch Linux/Manjaro
```sh
pacman -S base-devel
```

## Building the images
```sh
git clone https://github.com/freifunk-gluon/gluon.git gluon -b v2016.1.x
cd gluon
git clone https://github.com/freifunken/site-fffl.git site -b v2016.1.x
```

```sh
make GLUON_TARGET=?
```

```sh
make update
make clean GLUON_TARGET=ar71xx-generic
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental BROKEN=1
```
If the build still fails after some retries,
slow down and simplify the task:
```sh
make V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```

## Misc
Prevent shitty #clownflare from stopping your build due to broken downloads:
* https://github.com/apenwarr/sshuttle
  * https://blog.marco-ilgner.de/article/vpn-im-uberspace (**Outdated!**)
* https://wiki.freifunk.net/Vpn03
  * https://ca.berlin.freifunk.net/
  * https://config.berlin.freifunk.net/expert/form

## Resources
* http://gluon.readthedocs.io/en/latest/user/getting_started.html
