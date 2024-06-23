# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLUGIN_COMMIT=0c4740a4f8f1e615cc587b3cd3849fa23a623862
DESCRIPTION="VHDL synthesis (based on ghdl)"
HOMEPAGE="https://ghdl.github.io/ghdl/using/Synthesis.html"
SRC_URI="https://github.com/ghdl/ghdl-yosys-plugin/archive/${PLUGIN_COMMIT}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default
	ln -s "${WORKDIR}/${PN}-${PLUGIN_COMMIT}" "${P}"
}
