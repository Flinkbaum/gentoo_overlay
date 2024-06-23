# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="OpenCL-CLHPP"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Unified CPP language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-CLHPP"
SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-lang/ruby )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
