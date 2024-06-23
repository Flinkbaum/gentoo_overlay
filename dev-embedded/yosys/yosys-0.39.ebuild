# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_11 )
inherit python-any-r1

SRC_URI="https://github.com/YosysHQ/${PN}/archive/refs/tags/${P}.tar.gz https://github.com/YosysHQ/${PN}/releases/download/${P}/abc.tar.gz"
DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="https://yosyshq.net/yosys/"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/readline:=
	dev-libs/libffi:=
	dev-vcs/git
	dev-lang/tcl:=
	media-gfx/graphviz
	"

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	dev-libs/boost
	${RDEPEND}"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	ln -s "${WORKDIR}/abc-yosys-experimental" abc
	sed "s/^ABCREV = .*/ABCREV = default/g" -i Makefile
	default
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" STRIP=true install
}
