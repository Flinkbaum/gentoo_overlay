# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MAJREL="${PV%%.*}"
MAJMIDREL="${PV%.*}"
MIDREL="${MAJMIDREL#*.}"
MINREL="${PV##*.}"

DESCRIPTION="Sequential object-oriented simPlex"
HOMEPAGE="https://github.com/scipopt/soplex"
SRC_URI="https://github.com/scipopt/soplex/archive/refs/tags/release-${MAJREL}${MIDREL}${MINREL}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+boost"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-libs/zlib
dev-libs/gmp
dev-libs/boost
"
src_unpack() {
	default

	mv "${PN}-release-${MAJREL}${MIDREL}${MINREL}" "${P}"
}

