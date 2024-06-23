# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
SRC_URI="https://github.com/YosysHQ/nextpnr/archive/refs/tags/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/boost dev-cpp/eigen sci-electronics/icestorm dev-embedded/yosys sci-electronics/icestorm"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="ice40 ecp5 nexus generic"

src_unpack() {
	default
	ln -s "${WORKDIR}/nextpnr-${P}" "${WORKDIR}/${P}"
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
