# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT=1a40ae75d4eebee9cce73a2c4d634fd42ed0110f

DESCRIPTION="Tools for analysing and creating bitstreams for Lattice iCE40 FPGAs"
HOMEPAGE="https://clifford.at/icestorm"
SRC_URI="https://github.com/YosysHQ/icestorm/archive/${COMMIT}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default
	ln -s "${WORKDIR}/${PN}-${COMMIT}" "${P}"
}
