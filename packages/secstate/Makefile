# Copyright (C) 2011 Tresys Technology, LLC
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#

# The name of the package
PKGNAME := secstate

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 0.6.0

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
RELEASE := 1.el6

# snag the architecture, hard code an arch if cross-compiling or going noarch
ARCH := noarch

# srpm file name
SRPM := secstate-0.6.0-1.el6.src.rpm
RPM := $(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
SRPM_OUTPUT_DIR ?= $(OUTPUT_DIR)

# Exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
# The filter-out function is called to drop a circular dep when doing non-mock builds (ie SRPM_OUTPUT_DIR = CURDIR)
RPM_DEPS :=  Makefile $(filter-out $(SRPM_OUTPUT_DIR)/$(SRPM), $(shell /bin/readlink -f $(SRPM)))

RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)' --buildroot $(RPM_BUILDROOT)

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES);\
$(call MKDIR,$(RPM_TOPDIR)/SPECS);\
$(call MKDIR,$(RPM_TOPDIR)/BUILD);\
$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH));\
$(call MKDIR,$(RPM_TOPDIR)/SRPMS);
endef

all: $(PKGNAME)-rpm $(PKGNAME)-srpm

rpm: $(PKGNAME)-rpm

srpm: $(PKGNAME)-srpm

$(PKGNAME)-rpm: $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

$(PKGNAME)-srpm: $(SRPM_OUTPUT_DIR)/$(SRPM)

$(OUTPUT_DIR)/$(RPM): $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@echo "Building $(PKGNAME) RPM..."
	$(call rpm-prep)
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild $(RPMBUILD_ARGS) -bb $<
	mv  $(RPM_TOPDIR)/RPMS/$(ARCH)/$(PKGNAME)-$(VERSION)-$(RELEASE)*.rpm $(OUTPUT_DIR)

$(SRPM_OUTPUT_DIR)/$(SRPM): $(RPM_DEPS)
	@if [ ! "$@" -ef "$(SRPM)" ]; then\
		@echo "Copying SRPM into place...";\
		$(call rpm-prep)\
		cp  $(SRPM) $(SRPM_OUTPUT_DIR) 2>&1 1>/dev/null;\
	fi

clean:
	$(RM) -r $(RPM_TMPDIR)

bare: clean
	$(RM) $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

.PHONY: all $(PKGNAME)-rpm $(PKGNAME)-srpm clean bare rpm srpm
