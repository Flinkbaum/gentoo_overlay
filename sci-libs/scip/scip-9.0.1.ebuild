# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MAJREL="${PV%%.*}"
MAJMIDREL="${PV%.*}"
MIDREL="${MAJMIDREL#*.}"
MINREL="${PV##*.}"

DESCRIPTION="Solving Constraint Integer Programs"
HOMEPAGE="https://github.com/scipopt/scip"
SRC_URI="https://github.com/scipopt/scip/archive/refs/tags/v${MAJREL}${MIDREL}${MINREL}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+papilo +zimpl +ipopt"



DEPEND="sys-libs/zlib
dev-libs/gmp
sys-libs/readline
sci-libs/soplex
dev-cpp/tbb
dev-libs/mpfr
papilo? ( sci-libs/papilo )
zimpl? ( sci-libs/zimpl )
ipopt? ( sci-libs/ipopt )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default

	mv "${PN}-${MAJREL}${MIDREL}${MINREL}" "${P}"
}

src_configure() {
	local mycmakeargs=(
		-DPAPILO=$(usex papilo on off)
		-DIPOPT=$(usex ipopt on off)
		-DZIMPL=$(usex zimpl on off)
	)
	cmake_src_configure
}
