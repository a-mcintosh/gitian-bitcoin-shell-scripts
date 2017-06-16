#!/bin/sh
#  --------------------------------------------------------------------------
#  -- Aubrey McIntosh, PhD
#  -- 1497463063  $Id$
#  -- gitian build of bitcoin v0.14.1
#  -- run this a root@debian from the console
#
#
#  -- candidate code to execute from preseed during system installation.
#  --------------------------------------------------------------------------

sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
/etc/init.d/ssh restart


