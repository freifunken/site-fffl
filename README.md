## Dependencies
Arch Linux/Manjaro
```sh
# rank mirrors by speed and filter the out of date ones
sudo pacman-mirrors -g
# synchronize repo databases and update your system
sudo pacman -Syyu
# install package group for development purposes
sudo pacman -S base-devel gcc49
```

## Enhancing trust in source's integrity

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
git --version # >=v1.7.9
gpg2 --search-key mschiffer@universe-factory.net
gpg2 --search-key freifunk@schloss.stras.se
```

## Building the images

### Updating build-system
```sh
# Arch Linux/Manjaro
sudo pacman -Syyu

# Debian
sudo aptitude full-upgrade
```

### Cloning repositories
```sh
git clone https://github.com/freifunk-gluon/gluon.git gluon -b v2016.1.4
cd gluon
git clone https://github.com/freifunken/site-fffl.git site -b l2tp-v2016.1.x
```

### [Verifying signature](https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work) of checked out commit
Depending on your GPG truststore this might or might not get any usable results.
```sh
git tag -v v2016.1.4
git log --show-signature -1
(cd site && git log --show-signature -1)
```

### Listing available targets
```sh
make update
make GLUON_TARGET=?
```

### (Re-)Starting the build process
```sh
make update
make clean GLUON_TARGET=ar71xx-generic
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental BROKEN=1
```

#### Failure
If the build fails, even after some retries, ...

##### Simplifying
```sh
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```
```sh
make V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```

##### Legacy GNU Compiler Collection
~~`make -j$(nproc) V=s CC=gcc-4.9 GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental`~~

```sh
mkdir -p $HOME/bin
ln -s /usr/bin/c++-4.9.3 $HOME/bin/c++
ln -s /usr/bin/cpp-4.9.3 $HOME/bin/cpp
ln -s /usr/bin/g++-4.9.3 $HOME/bin/g++
ln -s /usr/bin/gcc-4.9.3 $HOME/bin/gcc
ln -s /usr/bin/gcc-4.9.3 $HOME/bin/cc
```
Temporarily
```sh
PATH=$HOME/bin:$PATH
# clean the entire tree,
# so the toolchain will be rebuilt as well
make dirclean
make -j$(nproc) V=s GLUON_TARGET=ar71xx-generic GLUON_BRANCH=experimental
```
##### `$ sshuttle`
Prevent shitty #clownflare from stopping your build due to **broken downloads**:

```sh
sudo pacman -Syyu
sudo pacman -S python python-pip
pip install sshuttle
```
**`.ssh/config`**
```
Host sshuttle
    HostName SERVER.uberspace.de
    User USER
    IdentityFile $HOME/.ssh/SSHKEYFILE
    IdentitiesOnly yes
```
**`alias` in `.bashrc`**
```sh
echo "alias clownflare='sshuttle --dns -v -r sshuttle 0/0'" >> ~/.bashrc
source ~/.bashrc
```
Forward all traffic (even DNS queries are being proxied)
```sh
clownflare
```

## Resources
* http://gluon.readthedocs.io/en/latest/user/getting_started.html
* https://github.com/apenwarr/sshuttle
