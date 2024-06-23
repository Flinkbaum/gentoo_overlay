# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Google's OR-tools"
HOMEPAGE="https://github.com/google/or-tools"
SRC_URI="https://github.com/google/or-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+coinor highs +scip"

DEPEND="sys-libs/zlib
dev-cpp/tbb
dev-cpp/eigen
coinor? ( sci-libs/coinor-cbc )
highs? ( sci-libs/HiGHS )
scip? ( sci-libs/scip )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DUSE_COINOR=$(usex coinor ON OFF)
		-DUSE_HIGHS=$(usex highs ON OFF)
		-DUSE_SCIP=$(usex scip ON OFF)
		# we rebuild these libraries, since gentoo uses c++14 for abseil, while or-tools requires abseil build for c++17
		-DBUILD_absl=ON
		-DBUILD_Protobuf=ON
		-DBUILD_re2=ON
	)

	cmake_src_configure
}
