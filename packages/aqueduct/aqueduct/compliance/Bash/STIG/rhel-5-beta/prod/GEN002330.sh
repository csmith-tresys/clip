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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 18-jan-2012 to reference GEN002320.sh


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22367
#Group Title: GEN002330
#Rule ID: SV-26494r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002330
#Rule Title: Audio devices must not have extended ACLs.
#
#Vulnerability Discussion: File system ACLs can provide access to 
#files beyond what is allowed by the mode numbers of the files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of audio devices.
# ls -lL /dev/audio* /dev/snd/*
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [device file]    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002330

#Start-Lockdown

# The audio devices are created with udev and are configured in GEN002320.sh.
# By default udev doesn't create the devices with ACLs. 
