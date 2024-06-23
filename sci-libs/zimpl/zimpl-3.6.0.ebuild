# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

VERSION_COMMIT="10a085f7bf52abc54c9788ea9231647ff1d80bb8"

DESCRIPTION="Language to translate the mathematical model of a problem into a linear program"
HOMEPAGE="https://zimpl.zib.de/"
SRC_URI="https://github.com/scipopt/zimpl/archive/${VERSION_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/gmp
sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default

	mv "zimpl-${VERSION_COMMIT}" "${P}"
}
