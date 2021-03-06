#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
# 
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4370
#Group Title: The traceroute command group ownership
#Rule ID: SV-28395r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003980
#Rule Title: The traceroute command must be group-owned by sys, bin, 
#root, or system.
#
#Vulnerability Discussion: If the group owner of the traceroute command 
#has not been set to a system group, unauthorized users could have 
#access to the command and use it to gain information regarding a 
#network's topology inside of the firewall. This information may 
#allow an attacker to determine trusted routers and other network 
#information that may lead to system and network compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the traceroute file.
#
#Procedure:
# ls -lL /bin/traceroute
#
#If the traceroute command is not group-owned by root, sys, bin, 
#or system, this is a finding.
#
#Fix Text: Change the group-owner of the traceroute command to root.
#
#Procedure:
# chgrp root /bin/traceroute 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003980

#Start-Lockdown

if [ -a "/bin/traceroute" ]
then
  CURGROUP=`stat -c %G /bin/traceroute`;
  if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
  then
      chgrp root /bin/traceroute
  fi
fi

