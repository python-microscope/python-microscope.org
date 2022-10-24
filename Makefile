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
INKSCAPE ?= inkscape
PYTHON3 ?= python3

# Use the submodules by default but make it possible to link to a
# local clone or whatever.
MICROSCOPE_SRC ?= src

# This requires .ssh/config to be set with this host
SSH_HOST = microscope
SSH_TARGET_DIR = ./www


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
	@echo '   make server      test web server at http://0.0.0.0:8000/'
	@echo ''
	@echo 'Variables:'
	@echo '   MICROSCOPE_SRC    path for python-microscope repo'
	@echo ''
	@echo 'Most likely, just do:'
	@echo ''
	@echo '   make html'
	@echo '   make server'
	@echo ''
	@echo 'If you want to update the Microscope source repo'
	@echo ''
	@echo '   cd src/'
	@echo '   git pull --ff-only origin master'
	@echo '   cd ..'
	@echo '   git commit src -m "src: update python-microscope submodule"'


BOOTSTRAP_ICONS_FILES = \
  node_modules/bootstrap-icons/icons/bounding-box.svg \
  node_modules/bootstrap-icons/icons/box-seam.svg \
  node_modules/bootstrap-icons/icons/card-list.svg \
  node_modules/bootstrap-icons/icons/code-slash.svg \
  node_modules/bootstrap-icons/icons/file-text.svg \
  node_modules/bootstrap-icons/icons/gear.svg \
  node_modules/bootstrap-icons/icons/people.svg \
  node_modules/bootstrap-icons/icons/person-plus.svg

BOOTSTRAP_FILES = \
  node_modules/bootstrap/dist/css/bootstrap.min.css \
  node_modules/bootstrap/dist/js/bootstrap.bundle.min.js

JQUERY_FILES = \
  node_modules/jquery/dist/jquery.slim.min.js

THIRD_PARTY_FILES = \
  $(BOOTSTRAP_ICONS_FILES) \
  $(BOOTSTRAP_FILES) \
  $(JQUERY_FILES)

# HACK: we need multiple files from the same yarn package so a single
# recipe would install multiple files.  However, Make does not like
# that (see
## https://www.gnu.org/software/automake/manual/html_node/Multiple-Outputs.html
## ).  So we just lie and instead list only one file per package.
THIRD_PARTY_FILES_ONE = \
  node_modules/bootstrap-icons/package.json \
  node_modules/bootstrap/package.json \
  node_modules/jquery/package.json

node_modules/bootstrap-icons/package.json:
	$(YARN) add bootstrap-icons@1.3.0
node_modules/bootstrap/package.json:
	$(YARN) add bootstrap@4.5.3
node_modules/jquery/package.json:
	$(YARN) add jquery@3.5.1


_static/microscope-logo-96-dpi.png: _static/microscope-logo.svg
	inkscape --file $< \
	    --export-dpi 96 \
	    --export-png $@


html: sync-doc api-doc $(THIRD_PARTY_FILES_ONE)
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
	    "$(MICROSCOPE_SRC)/doc/" "$(DOC_DIR)"
	cp "$(MICROSCOPE_SRC)/NEWS.rst" "$(DOC_DIR)/../NEWS.rst"

clean:
	$(RM) "$(DOC_DIR)/../NEWS.rst"
	$(RM) -r \
	    "$(BUILD_DIR)" \
	    "$(APIDOC_DIR)" \
	    "$(DOC_DIR)" \
	    "node_modules"

server:
	$(PYTHON3) -m http.server --directory ${BUILD_DIR}

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
