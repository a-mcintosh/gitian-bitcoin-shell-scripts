#  --------------------------------------------------------------------------
#  -- Aubrey McIntosh, PhD
#  -- 1497463063  $Id$
#  -- gitian build of bitcoin v0.14.1
#  -- run this a debian@debian
#  --------------------------------------------------------------------------


#  --------------------------------------------------------------------------
export VERSION=0.14.1
mkdir -p ~/opt/gitian
cd ~/opt/gitian


#  --------------------------------------------------------------------------
wget http://archive.ubuntu.com/ubuntu/pool/universe/v/vm-builder/vm-builder_0.12.4+bzr494.orig.tar.gz
echo "76cbf8c52c391160b2641e7120dbade5afded713afaa6032f733a261f13e6a8e  vm-builder_0.12.4+bzr494.orig.tar.gz" | sha256sum -c
# (verification -- must return OK)
tar -zxvf vm-builder_0.12.4+bzr494.orig.tar.gz

pushd vm-builder-0.12.4+bzr494
sudo python setup.py install
popd

git clone https://github.com/bitcoin/bitcoin.git
git clone https://github.com/bitcoin-core/bitcoin-detached-sigs.git
git clone https://github.com/devrandom/gitian-builder.git
git clone https://github.com/bitcoin-core/gitian.sigs.git

pushd gitian-builder
bin/make-base-vm --lxc --arch amd64 --suite trusty
popd

#  --------------------------------------------------------------------------
pushd ./gitian-builder
git pull
popd



