#Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Equivalence Checking with Yosys"
HOMEPAGE="https://github.com/YosysHQ/eqy"
SRC_URI="https://github.com/YosysHQ/eqy/archive/refs/tags/yosys-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="~sci-electronics/yosys-${PV}"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default

	mv "${PN}-yosys-${PV}" "${P}"
}
