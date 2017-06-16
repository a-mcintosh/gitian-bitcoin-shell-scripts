#  --------------------------------------------------------------------------
#  -- Aubrey McIntosh, PhD
#  -- 1497463063  $Id$
#  -- gitian build of bitcoin v0.14.1
#  -- run this a debian@debian
#  --------------------------------------------------------------------------


#  --------------------------------------------------------------------------
export VERSION=0.14.1
cd ~/opt/gitian


#  --------------------------------------------------------------------------
pushd ./bitcoin
git fetch
git checkout v${VERSION}
popd

pushd ./gitian-builder
mkdir -p inputs
wget -P inputs https://bitcoincore.org/cfields/osslsigncode-Backports-to-1.7.1.patch
wget -P inputs http://downloads.sourceforge.net/project/osslsigncode/osslsigncode/osslsigncode-1.7.1.tar.gz
./bin/gbuild --memory 3000 --commit bitcoin=v${VERSION} ../bitcoin/contrib/gitian-descriptors/gitian-linux.yml
popd


