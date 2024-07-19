# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/The-OpenROAD-Project/OpenROAD"

inherit cmake git-r3

DESCRIPTION="RTL-to-GDSII Flow"
HOMEPAGE="https://theopenroadproject.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/eigen
	app-text/pandoc-bin
	~dev-lang/swig-4.1.1
	dev-lang/tcl
	dev-libs/boost
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/spdlog
	dev-tcltk/tclreadline
	dev-tcltk/tcllib
	dev-util/lcov
	dev-qt/qtimageformats:5
	dev-qt/qtcore:5
	dev-qt/qtcharts:5
	dev-qt/qtchooser
	sys-apps/groff
	sys-devel/flex
	sci-mathematics/abc
	sci-electronics/yosys
	sci-electronics/eqy
	sci-electronics/sby
	sci-libs/or-tools
	sci-libs/lemon
	sys-libs/readline
	sys-libs/libomp
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="test"

PATCHES=(
	"${FILESDIR}"/0001-Add_ABC_NAMESPACE_macro_definition_to_compile_flags.patch
	)

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test ON OFF)
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_ABC=ON
		# Turn of shared libs because of circular dependency between "db" and "zutil"
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}
