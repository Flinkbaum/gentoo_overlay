# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="RTL-to-GDSII Flow"
HOMEPAGE="https://theopenroadproject.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/eigen
	sci-libs/lemon
	dev-libs/spdlog
"
RDEPEND="${DEPEND}"
BDEPEND=""
