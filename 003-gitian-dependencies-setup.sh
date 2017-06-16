#  --------------------------------------------------------------------------
#  -- Aubrey McIntosh, PhD
#  -- 1497463063  $Id$
#  -- gitian build of bitcoin v0.14.1
#  -- run this a root@debian
#
#
#  -- candidate code to execute from preseed during system installation.
#  --------------------------------------------------------------------------
pushd /etc/apt/apt.conf.d
echo Acquire::http { Proxy "http://lifepod13.quarantine:3142"; }; > 01proxy
popd

apt-get install apt-cacher-ng
apt-get install git ruby sudo qemu-utils debootstrap lxc python-cheetah parted kpartx bridge-utils make ubuntu-archive-keyring curl
adduser debian sudo

