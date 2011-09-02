#! /usr/bin/make -f

## Default target
all:

## Make sure to update the version data
include make/version.mk

.PHONY: all
all: debian/changelog

# vim:set ft=make:
