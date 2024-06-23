#Relaismatrix/ Messung Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit python-single-r1

DESCRIPTION="A container-based approach to boot a full Android system on a regular Linux"
DESCRIPTION+=" system"
HOMEPAGE="https://waydro.id"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd nftables"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="app-containers/lxc
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/gbinder[${PYTHON_USEDEP}]
	')
	nftables? ( net-firewall/nftables )
	systemd? ( sys-apps/systemd )
	net-dns/dnsmasq
	${PYTHON_DEPS}
"

src_install() {
	emake DESTDIR="${D}" install USE_SYSTEMD="$(usex systemd 1 0)" USE_NFTABLES="$(usex nftables 1 0)"
	dodoc README.md
}
