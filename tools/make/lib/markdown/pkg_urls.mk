#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# VARIABLES #

# Define the path to the remark configuration file:
REMARK_PKG_URLS_CONF ?= $(CONFIG_DIR)/remark/.remarkrc.js

# Define the path to the remark ignore file:
# REMARK_PKG_URLS_IGNORE ?= $(CONFIG_DIR)/remark/.remarkignore FIXME
REMARK_PKG_URLS_IGNORE ?= $(ROOT_DIR)/.remarkignore

# Define the path to a plugin which processes Markdown table of contents comments:
REMARK_PKG_URLS_PLUGIN ?= $(TOOLS_PKGS_DIR)/remark/plugins/remark-stdlib-urls-github
REMARK_PKG_URLS_PLUGIN_SETTINGS ?=
REMARK_PKG_URLS_PLUGIN_FLAGS ?= --use $(REMARK_PKG_URLS_PLUGIN)=$(REMARK_PKG_URLS_PLUGIN_SETTINGS)

# Define command-line options when invoking the remark executable:
REMARK_PKG_URLS_FLAGS ?= \
	--ext $(MARKDOWN_FILENAME_EXT) \
	--rc-path $(REMARK_PKG_URLS_CONF) \
	--ignore-path $(REMARK_PKG_URLS_IGNORE)

# Define the remark output option:
REMARK_PKG_URLS_OUTPUT_FLAG ?= --output


# RULES #

#/
# Updates Markdown files by resolving package identifiers to GitHub repository URLs.
#
# @param {string} [MARKDOWN_FILTER] - file path pattern (e.g., `.*/math/base/special/.*`)
# @param {string} [MARKDOWN_PATTERN] - filename pattern (e.g., `*.md`)
#
# @example
# make markdown-pkg-urls
#
# @example
# make markdown-pkg-urls MARKDOWN_PATTERN='README.md' MARKDOWN_FILTER='.*/math/base/special/.*'

markdown-pkg-urls: $(NODE_MODULES) assert-clean-working-directory
	$(QUIET) NODE_PATH="$(NODE_PATH)" $(REMARK) $(MARKDOWN_FILES) \
		$(REMARK_PKG_URLS_FLAGS) \
		$(REMARK_PKG_URLS_PLUGIN_FLAGS) \
		$(REMARK_PKG_URLS_OUTPUT_FLAG)

.PHONY: markdown-pkg-urls