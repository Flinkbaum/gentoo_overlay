# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Linear optimization software"
HOMEPAGE="https://github.com/ERGO-Code/HiGHS"
SRC_URI="https://github.com/ERGO-Code/HiGHS/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""
