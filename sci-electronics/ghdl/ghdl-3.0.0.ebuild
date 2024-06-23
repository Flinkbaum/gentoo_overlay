# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit llvm autotools

DESCRIPTION="VHDL 2008/93/87 simulator"
HOMEPAGE="https://ghdl.github.io/ghdl/index.html"
SRC_URI="https://github.com/ghdl/ghdl/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-devel/llvm:14"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/gnat-gpl
		sys-devel/gcc
		sys-devel/clang
		app-portage/portage-utils"


src_configure() {
	mkdir build && cd build
	gnatmake='/usr/x86_64-pc-linux-gnu/gcc-bin/10/x86_64-pc-linux-gnu-gnatmake'
	env GNATMAKE="${gnatmake}" ../configure --with-llvm-config
}

src_compile() {
	cd build
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	cd build
	default
}
