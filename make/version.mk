###
## version.mk  -  Helper rules used for easy configuration
###

## Shell expression to compute the current GIT version
compute_git_version :=							\
	git update-index --refresh >/dev/null 2>&1 || true;		\
	git describe --tags --always --dirty=-patched-0 2>/dev/null	\
		| sed -e 's/^v//';

compute_log_version :=							\
	head -1 debian/changelog 2>/dev/null				\
		| sed -e 's/^.*(\(.*\)).*/\1/';

## Find the currently-computed version and precomputed version
VERSION_LOG := $(shell $(compute_log_version))
VERSION_GIT := $(shell $(compute_git_version))
-include make/version.gen

## Don't try to rebuild this makefile
make/version.mk:
	@;

## If we have neither, bail out noisily
ifeq ("$(VERSION_GIT)$(VERSION)","")
$(error Unable to locate source code version)
endif
ifeq ("$(VERSION_GIT)$(VERSION_LOG)","")
$(error Unable to validate changelog)
endif

## Figure out what needs regenerating
regenerate_version_gen =
regenerate_debian_changelog =
ifneq ("$(VERSION_GIT)","")
 ifneq ("$(VERSION_GIT)","$(VERSION)")
  regenerate_version_gen = 1
 endif
 ifneq ("$(VERSION_GIT)","$(VERSION_LOG)")
  regenerate_debian_changelog = 1
 endif
endif

ifeq ("$(regenerate_version_gen)","")
make/version.gen:
	touch $@
else
## Record the GIT version into a file for distribution
.PHONY: .DO-GENERATE-VERSION
make/version.gen: .DO-GENERATE-VERSION
	@( echo -n "VERSION := "; $(compute_git_version) ) >$@
endif

ifeq ("$(regenerate_debian_changelog)","")
debian/changelog:
	touch $@
else
## Record the GIT changelog into a file for distribution
.PHONY: .DO-GENERATE-VERSION
debian/changelog: .DO-GENERATE-VERSION
	daprads genchangelog -d 'unstable' 'jklm-files' >$@
endif

