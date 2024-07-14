# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ABSEIL_VERSION="20230125.3"
PROTOBUF_VERSION="v23.3"
RE2_VERSION="2023-07-01"

inherit cmake

DESCRIPTION="Google's OR-tools"
HOMEPAGE="https://github.com/google/or-tools"
SRC_URI="https://github.com/google/or-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/abseil/abseil-cpp/archive/refs/tags/${ABSEIL_VERSION}.tar.gz
https://github.com/protocolbuffers/protobuf/archive/refs/tags/${PROTOBUF_VERSION}.tar.gz
https://github.com/google/re2/archive/refs/tags/${RE2_VERSION}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+coinor highs +scip"

DEPEND="sys-libs/zlib
dev-cpp/tbb
dev-cpp/eigen
~dev-cpp/abseil-cpp-20230125.3
~dev-libs/protobuf-23.3
~dev-libs/re2-0.2023.07.01
coinor? ( sci-libs/coinor-cbc )
highs? ( sci-libs/HiGHS )
scip? ( sci-libs/scip )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	cmake_src_prepare

	eapply "${FILESDIR}/0001-modified-cmake-sources.patch"
}

src_configure() {
	local mycmakeargs=(
		-DUSE_COINOR=$(usex coinor ON OFF)
		-DUSE_HIGHS=$(usex highs ON OFF)
		-DUSE_SCIP=$(usex scip ON OFF)
	)

	cmake_src_configure
}
