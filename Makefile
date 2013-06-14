#! /usr/bin/make -f

## Default target
all:

## Make sure to update the version data
include make/version.mk

.PHONY: all
all: debian/changelog

APT_DEBIAN_FILES =				\
	sources.list.d/debian-wheezy.list	\
	sources.list.d/debian-testing.list	\
	sources.list.d/debian-unstable.list	\
	sources.list.d/debian-experimental.list

## Build the relevant APT mirror targets
define apt_mirror
.PHONY: apt-config-$1
apt-config-$1: $$(APT_DEBIAN_FILES:%=build/apt-$1/%)

build/apt-$1/%: apt/%
	@mkdir -p $$(@D)
	sed -e 's!@MIRROR@!$2!g' <$$< >$$@

all: apt-config-$1

endef

$(eval $(call apt_mirror,iad,http://rocky-mountain.csail.mit.edu/debian/))
$(eval $(call apt_mirror,nuq,http://mirrors.us.kernel.org/debian/))

# vim:set ft=make:
