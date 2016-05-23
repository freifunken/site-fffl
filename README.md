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

## Improve trust in source's integrity

There are, as always, several grades of verification and you should decide,
depending on your attacker model, which you want and/or need,
and therefore ensure you will not be victim to a MITM-Attack.<br>
Unfortunately, bootstrapping trust can be quite tricky.

### [`.gitconfig`](https://github.com/git/git/blob/master/Documentation/config.txt)
Git is capable of making sure every object received during a transfer still matches its SHA-1 checksum and points to valid objects. It might **slow down** the operation, especially on large repositories!
```sh
git config --null --get transfer.fsckobjects
git config --null --get fetch.fsckobjects
# For server side of Git:
# git config --null --get receive.fsckobjects
# If the previous output is false or null, set it to true
git config --global transfer.fsckobjects true
git config --global fetch.fsckobjects true
# For server side of Git:
# git config --global receive.fsckobjects true
```

### GPG Keys

Don't put too much confidence in unverified public keys (Ask for fingerpint face to face)
* [Gefälschte PGP-Keys im Umlauf](http://www.heise.de/ct/ausgabe/2015-6-Gefaelschte-PGP-Keys-im-Umlauf-2549724.html)
```sh
git --version # >v1.7.9
gpg2 --search-key mschiffer@universe-factory.net
gpg2 --search-key freifunk@schloss.stras.se
```

## Building the images

### Update build-system
```sh
# Arch Linux/Manjaro
sudo pacman -Syyu

# Debian
sudo aptitude full-upgrade
```

### Clone repositories
```sh
git clone https://github.com/freifunk-gluon/gluon.git gluon -b v2016.1.x
cd gluon
git clone https://github.com/freifunken/site-fffl.git site -b l2tp-v2016.1.x
```

### [Verify signature](https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work) of checked out commit
Depending on your GPG truststore this might or might not get any usable results.
```sh
git log --show-signature -1
(cd site && git log --show-signature -1)
```

### List available targets
```sh
make GLUON_TARGET=?
```

### Start build
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
