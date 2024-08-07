# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
COMMIT="eb099a9244857219ee33d627540dc5e2316893ae"
SRC_URI="https://github.com/YosysHQ/nextpnr/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/boost
dev-cpp/eigen
sci-electronics/icestorm
sci-electronics/yosys
sci-electronics/icestorm"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="ice40 ecp5 nexus generic"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}/nextpnr-${COMMIT}" "${WORKDIR}/${P}"
}

src_configure() {
	local darch=''
	for current_use in $IUSE ; do
		if use $current_use ; then
			if [[ -z $darch ]] ; then
				darch=$current_use
			else
				darch="$darch;$current_use"
			fi
		fi
	done
	local mycmakeargs=(
		-DARCH="$darch"
		$(usex ice40 -DICESTORM_INSTALL_PREFIX=/usr/local '')
		$(usex ecp5 -DTRELLIS_INSTALL_PREFIX=/usr/local '')
		$(usex nexus -DOXIDE_INSTALL_PREFIX=$HOME/.cargo '')
	)
	cmake_src_configure
}
