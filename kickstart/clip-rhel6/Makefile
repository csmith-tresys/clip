# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

NAME := $(shell basename $(CURDIR))
KS := $(NAME).ks

ISO_VERSION ?= 1

ROOT_DIR ?= $(CURDIR)
TMP_DIR ?= $(ROOT_DIR)/tmp
BUILD_DIR ?= $(TMP_DIR)/clip-iso-build
SUPPORT_DIR ?= $(ROOT_DIR)/support

OUTPUT_DIR ?= $(ROOT_DIR)

PUNGI_OS_DIR := $(BUILD_DIR)/$(ISO_VERSION)/$(shell uname -i)/os/
PUNGI_ISO_DIR := $(BUILD_DIR)/$(ISO_VERSION)/$(shell uname -i)/iso/

LIVECD_CREATOR ?= $(SUPPORT_DIR)/livecd-creator
PUNGI ?= $(SUPPORT_DIR)/pungi

DEBUG ?= y

PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="$(ISO_VERSION)" --name="$(NAME)" --nosource --force
LIVECD_ARGS := --skip-compress --extra-space=104857600 --config="$(BUILD_DIR)/$(NAME).ks" --fslabel="$(NAME)"

# These variables are usually passed in from CONFIG_BUILD to the top level Makefile.
# This will only be set here if we are running setup-ks by hand.
CONFIG_BUILD_BASH_VARS ?= export CONFIG_BUILD_PRODUCTION=n CONFIG_BUILD_ENFORCING_MODE=y CONFIG_BUILD_UNCONFINED_TOOR=y CONFIG_BUILD_SECSTATE_REMEDIATE=y ISO_VERSION=debug

# This is only useful for building out of this subdir.  The top-level Makefile passes this variable down
# pointing to the yum repos CLIP creates and manages in repos/*.  What this means is that you should
# probably just ignore this.
REPO_LINES ?= repo --name=centos --baseurl=http://mirror.centos.org/centos/6.2/os/$$basearch\nrepo --name=epel   --baseurl=http://download.fedora.redhat.com/pub/epel/$(RHEL_VER)/$$basearch

DEPS := $(PUNGI) $(LIVECD_CREATOR)
SETUP_DEPS := $(CURDIR)/Makefile $(CURDIR)/$(KS)

all: iso livecd setup-ks

iso: $(DEPS) $(ADDTL_DEPS) setup-ks
	@echo "Gathering things with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	@# Don't remove the "cd $(BUILD_DIR)" below b/c a bug in pungi ends up creating empty dirs in curdir.  This avoids confusion.
	$(VERBOSE)cd $(BUILD_DIR); sudo $(PUNGI) $(PUNGI_ARGS) -GCB -c "$(BUILD_DIR)/$(KS)"
	@echo "Fixing the boot menu..."
	$(VERBOSE)sudo sed -i -e "s/^label linux$$/label clip/" \
	       -e "s/append initrd=initrd.img$$/append initrd=initrd.img ks=cdrom:$(KS)/" \
	       -e "s/or upgrade an existing system/$(NAME)/" \
	$(PUNGI_OS_DIR)/isolinux/isolinux.cfg
	@echo "Building ISO with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	@# Don't remove the "cd $(BUILD_DIR)" below b/c a bug in pungi ends up creating empty dirs in curdir.  This avoids confusion.
	$(VERBOSE)cd $(BUILD_DIR);sudo $(PUNGI) $(PUNGI_ARGS) -I -c $(BUILD_DIR)/$(KS)
	$(VERBOSE)sudo mv --force $(PUNGI_ISO_DIR)/$(NAME)-$(ISO_VERSION)-x86_64.iso $(OUTPUT_DIR)/

setup-ks: $(SETUP_DEPS)
	$(VERBOSE)test -d $(PUNGI_OS_DIR) || mkdir -p $(PUNGI_OS_DIR)
	$(VERBOSE)cp --force $(CURDIR)/$(KS) $(BUILD_DIR)/$(KS)
	@echo "Modifying kickstart with build variables..."
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-PLACEHOLDER;$(CONFIG_BUILD_BASH_VARS);' $(BUILD_DIR)/$(KS) || true
	$(VERBOSE)sed -e 's/^repo/#repo/' $(BUILD_DIR)/$(KS) > $(PUNGI_OS_DIR)/$(KS)

livecd: $(DEPS) $(ADDTL_DEPS) setup-ks
	$(VERBOSE)cp --force $(MAYFLOWER) $(BUILD_DIR)/mayflower
	$(VERBOSE)cp --force $(LIVECD_CREATOR) $(BUILD_DIR)/livecd-creator
	$(VERBOSE)sed -i -e 's;CDLABEL;live:CDLABEL;g' $(BUILD_DIR)/livecd-creator
	@echo "Live CD Creator needs root permissions - please enter your sudo password if prompted."
	$(VERBOSE)sudo $(BUILD_DIR)/livecd-creator  $(LIVECD_ARGS)
	$(VERBOSE)mv --force $(NAME).iso $(OUTPUT_DIR)/

clean:
	$(VERBOSE)sudo rm -rf $(BUILD_DIR)

bare: clean
	rm -rf $(TMP_DIR)

.PHONY: all livecd iso clean bare setup-ks
