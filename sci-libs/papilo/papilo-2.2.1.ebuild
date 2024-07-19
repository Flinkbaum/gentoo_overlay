# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parallel Presolve for Integer and Linear Optimization"
HOMEPAGE="https://github.com/scipopt/papilo"
SRC_URI="https://github.com/scipopt/papilo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+soplex -highs"

DEPEND="dev-libs/boost[bzip2,zlib]
dev-libs/gmp
dev-cpp/tbb
soplex? ( sci-libs/soplex )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DHIGHS=$(usex highs ON OFF)
	)
	cmake_src_configure
}
