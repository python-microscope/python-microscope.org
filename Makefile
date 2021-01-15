## Copyright (C) 2021 David Miguel Susano Pinto <david.pinto@bioch.ox.ac.uk>
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

SPHINX_BUILD ?= sphinx-build
SPHINX_APIDOC ?= sphinx-apidoc
YARN ?= yarn
RSYNC ?= rsync

# Use the submodules by default but make it possible to link to a
# local clone or whatever.
MICROSCOPE_SRC ?= src

# This requires .ssh/config to be set with this host
SSH_HOST = microscope
SSH_TARGET_DIR = ./www2


CONF_DIR = .
SOURCE_DIR = content
BUILD_DIR = _build
DOC_DIR = $(SOURCE_DIR)/doc
APIDOC_DIR = $(DOC_DIR)/api


.PHONY: help build build-apidoc clean

help:
	@echo 'Makefile for the python-microscope.org website'
	@echo ''
	@echo 'Usage:'
	@echo '   make sync-doc    update the doc source with latest'
	@echo '   make api-doc     (re)generate the apidocs'
	@echo '   make html        (re)generate the web site'
	@echo '   make publish     upload to the interweb'
	@echo ''
	@echo 'Variables:'
	@echo '   MICROSCOPE_SRC    path for python-microscope repo'
	@echo ''
	@echo 'Most likely, do it in this order:'
	@echo ''
	@echo '   cd src'
	@echo '   git pull --ff-only origin master'
	@echo '   cd ..'
	@echo '   make sync-doc'
	@echo '   make api-doc'
	@echo '   make html'
	@echo '   make publish'


html: apidoc
	${SPHINX_BUILD} -c ${CONF_DIR} -b html ${SOURCE_DIR} ${BUILD_DIR}

api-doc:
	${SPHINX_APIDOC} \
	    --force --separate --module-first \
	    --tocfile index \
	    --output-dir $(APIDOC_DIR) \
	    ${MICROSCOPE_SRC}/microscope \
	    ${MICROSCOPE_SRC}/microscope/win32.py \
	    ${MICROSCOPE_SRC}/microscope/testsuite/*.py \
	    ${MICROSCOPE_SRC}/microscope/devices.py \
	    ${MICROSCOPE_SRC}/microscope/lasers/*.py \
	    ${MICROSCOPE_SRC}/microscope/deviceserver.py

sync-doc:
	$(RSYNC) \
	    --recursive \
	    --delete \
	    "$(MICROSCOPE_SRC)/doc/" "$(DOC_DIR)"
	cp "$(MICROSCOPE_SRC)/NEWS" "$(DOC_DIR)/../NEWS"

third-parties:
	$(YARN) add bootstrap@4.5.3
	$(YARN) add bootstrap-icons@1.3.0
	$(YARN) add jquery@3.5.1

clean:
	$(RM) "$(DOC_DIR)/../NEWS"
	$(RM) -r \
	    "$(BUILD_DIR)" \
	    "$(APIDOC_DIR)" \
	    "$(DOC_DIR)"

upload:
	$(RSYNC) -e "ssh" \
	    --partial --progress \
	    --recursive \
	    --verbose \
	    --compress \
	    --checksum \
	    --include tags \
	    --cvs-exclude \
	    --delete \
	    "$(BUILD_DIR)"/ "$(SSH_HOST):$(SSH_TARGET_DIR)"
