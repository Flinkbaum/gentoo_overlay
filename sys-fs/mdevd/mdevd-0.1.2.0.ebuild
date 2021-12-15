# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small daemon managing kernel hotplug events, similarly to udevd"
HOMEPAGE="https://skarnet.org/software/mdevd/"
SRC_URI="https://skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="static static-libs"

REQUIRED_USE="static? ( static-libs )"

DEPEND="~dev-libs/skalibs-2.9.3.0:=[static-libs?]"
RDEPEND="${DEPEND}"
BDEPEND=""

HTML_DOCS=( doc/. )

src_configure() {
	econf \
		--bindir=/bin \
		--dynlibdir=/usr/$(get_libdir) \
		--libdir=/usr/$(get_libdir)/${PN} \
		--with-sysdeps=/usr/$(get_libdir)/skalibs \
		--with-dynlib=/usr/$(get_libdir) \
		--with-lib=/usr/$(get_libdir)/skalibs \
		--enable-shared \
		$(use_enable static allstatic) \
		$(use_enable static static-libc) \
		$(use_enable static-libs static)
}
