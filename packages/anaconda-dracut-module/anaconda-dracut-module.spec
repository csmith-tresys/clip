Name: %{pkgname}
Version: %{version}
Release: %{release}
Summary: Example software package.
Requires: kernel

License: GPL or BSD
Group: System Environment/Base

BuildRequires: make, bash
BuildRoot: %{_tmppath}/%{name}-root

Source0: %{pkgname}-%{version}.tgz

%description
This package contains the example daemon.

%prep
#%setup -q -n %{pkgname}-%{version}
%setup -q -n %{pkgname}

#%build
#make

%install

install -m 0755 -d $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda
install -m 0755 anaconda-copy-cmdline.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-copy-cmdline.sh
install -m 0755 anaconda-copy-ks.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-copy-ks.sh
install -m 0755 anaconda-depmod.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-depmod.sh
install -m 0755 anaconda-diskroot $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-diskroot
install -m 0755 anaconda-ifcfg.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-ifcfg.sh
install -m 0755 anaconda-ks-sendheaders.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-ks-sendheaders.sh
install -m 0755 anaconda-lib.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-lib.sh
install -m 0755 anaconda-modprobe.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-modprobe.sh
install -m 0755 anaconda-netroot.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-netroot.sh
install -m 0755 anaconda-pre-shutdown.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/anaconda-pre-shutdown.sh
install -m 0755 driver-updates $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/driver-updates
install -m 0755 driver-updates-net.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/driver-updates-net.sh
install -m 0755 driver-updates@.service $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/driver-updates@.service
install -m 0755 driver-updates.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/driver-updates.sh
install -m 0755 fetch-driver-net.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/fetch-driver-net.sh
install -m 0755 fetch-kickstart-disk $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/fetch-kickstart-disk
install -m 0755 fetch-kickstart-net.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/fetch-kickstart-net.sh
install -m 0755 fetch-updates-disk $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/fetch-updates-disk
install -m 0755 kickstart-genrules.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/kickstart-genrules.sh
install -m 0755 module-setup.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/module-setup.sh
install -m 0755 parse-anaconda-dd.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-dd.sh
install -m 0755 parse-anaconda-kickstart.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-kickstart.sh
install -m 0755 parse-anaconda-net.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-net.sh
install -m 0755 parse-anaconda-options.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-options.sh
install -m 0755 parse-anaconda-repo.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-repo.sh
install -m 0755 parse-kickstart $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/parse-kickstart
install -m 0755 python-deps $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/python-deps
install -m 0755 repo-genrules.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/repo-genrules.sh
install -m 0755 save-initramfs.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/save-initramfs.sh
install -m 0755 updates-genrules.sh $RPM_BUILD_ROOT/usr/lib/dracut/modules.d/80anaconda/updates-genrules.sh
#rm -rf $RPM_BUILD_ROOT
#make install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
%dir /usr/lib/dracut/modules.d/80anaconda
/usr/lib/dracut/modules.d/80anaconda/anaconda-copy-cmdline.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-copy-ks.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-depmod.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-diskroot
/usr/lib/dracut/modules.d/80anaconda/anaconda-ifcfg.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-ks-sendheaders.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-lib.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-modprobe.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-netroot.sh
/usr/lib/dracut/modules.d/80anaconda/anaconda-pre-shutdown.sh
/usr/lib/dracut/modules.d/80anaconda/driver-updates
/usr/lib/dracut/modules.d/80anaconda/driver-updates-net.sh
/usr/lib/dracut/modules.d/80anaconda/driver-updates@.service
/usr/lib/dracut/modules.d/80anaconda/driver-updates.sh
/usr/lib/dracut/modules.d/80anaconda/fetch-driver-net.sh
/usr/lib/dracut/modules.d/80anaconda/fetch-kickstart-disk
/usr/lib/dracut/modules.d/80anaconda/fetch-kickstart-net.sh
/usr/lib/dracut/modules.d/80anaconda/fetch-updates-disk
/usr/lib/dracut/modules.d/80anaconda/kickstart-genrules.sh
/usr/lib/dracut/modules.d/80anaconda/module-setup.sh
/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-dd.sh
/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-kickstart.sh
/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-net.sh
/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-options.sh
/usr/lib/dracut/modules.d/80anaconda/parse-anaconda-repo.sh
/usr/lib/dracut/modules.d/80anaconda/parse-kickstart
/usr/lib/dracut/modules.d/80anaconda/python-deps
/usr/lib/dracut/modules.d/80anaconda/repo-genrules.sh
/usr/lib/dracut/modules.d/80anaconda/save-initramfs.sh
/usr/lib/dracut/modules.d/80anaconda/updates-genrules.sh

%post
/sbin/chkconfig --add example
/sbin/depmod

%changelog
* Mon Apr 18 2011 Spencer Shimko <sshimko@tresys.com> 1-1
- Example spec file.

