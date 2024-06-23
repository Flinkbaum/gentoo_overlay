# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Open Forward Erasure Codecs"
HOMEPAGE="http://openfec.org/"
SRC_URI="https://github.com/roc-streaming/openfec/archive/refs/tags/v${PV}.tar.gz"

LICENSE="CECILL-C	CECILL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"
