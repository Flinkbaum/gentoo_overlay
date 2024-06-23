# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Real-time audio streaming over the network"
HOMEPAGE="https://github.com/roc-streaming/roc-toolkit/"
SRC_URI="https://github.com/roc-streaming/roc-toolkit/archive/refs/tags/v${PV}.tar.gz"
IUSE="+openfec pulseaudio sox speexdsp tools"

PYTHON_COMPAT=( python3_11 )
inherit python-any-r1 scons-utils toolchain-funcs

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="|| ( sys-libs/libunwind sys-libs/llvm-libunwind )
	dev-libs/libuv
"
RDEPEND="${DEPEND}"
BDEPEND="tools? ( dev-util/gengetopt )
	dev-util/ragel
	dev-util/scons
	openfec? ( media-libs/openfec )
	pulseaudio? ( media-libs/libpulse )
	sox? ( media-sound/sox )
	speexdsp? ( media-libs/speexdsp )
"

src_compile() {
    scons_opts=(
	$(use !openfec && printf '%s' '--disable-openfec')
	$(use !sox && printf '%s' '--disable-sox')
	$(use !speexdsp && printf '%s' '--disable-speexdsp')
	$(use !pulseaudio && printf '%s' '--disable-pulseaudio')
	$(use !tools && printf '%s' '--disable-tools')
    )
    escons "${scons_opts[@]}" -Q
}

src_install() {
    escons DESTDIR="${D}" "${scons_opts[@]}" -Q install
}
