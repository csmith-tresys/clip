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
# on 12-Feb-2012 to add check before running fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22489
#Group Title: GEN005550
#Rule ID: SV-26802r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005550
#Rule Title: The SSH daemon must be configured with the Department of
#Defense (DoD) login banner.
#
#Vulnerability Discussion: Failure to display the DoD logon banner prior
#to a logon attempt will negate legal proceedings resulting from
#unauthorized access to system resources.
#
#The SSH service must be configured to display the DoD logon warning
#banner either through the SSH configuration or a wrapper program
#such as TCP_WRAPPERS.
#
#The SSH daemon may also be used to provide SFTP service. The warning
#banner configuration for SSH will apply to SFTP.
#
#Responsibility: System Administrator
#IAControls: ECWM-1
#
#Check Content: 
#Check that the SSH daemon is configured for logon warning banners.
# grep -i banner /etc/ssh/sshd_config | grep -v '^#'
# cat <banner file>
#Verify that the "Banner" configuration line is present and the file it references contains a login warning banner.
#
#Otherwise, check that TCP_WRAPPERS are configured for SSH and display a logon warning banner.
#
#If neither the SSH daemon nor TCP_WRAPPERS is configured to display a logon warning banner, this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add or edit a "Banner" setting that references a file containing a logon warning banner.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005550

#Start-Lockdown

grep -i banner /etc/ssh/sshd_config > /dev/null
if [ $? -eq 0 ]
then
  grep -i banner /etc/ssh/sshd_config | grep -v '^#' > /dev/null
  if [ $? -ne 0 ]
  then
    sed -i "/^#Banner/ c\Banner /etc/issue" /etc/ssh/sshd_config
  fi
else
  echo "#Adding for DISA $PDI" >> /etc/ssh/sshd_config
  echo "Banner /etc/issue" >> /etc/ssh/sshd_config
fi


