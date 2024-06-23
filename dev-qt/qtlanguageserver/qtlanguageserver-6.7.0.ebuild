EAPI=8

inherit qt6-build

DESCRIPTION="Implementation of the Language Server Protocol for Qt"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

RDEPEND="
	~dev-qt/qtbase-${PV}:6[network=,concurrent=,test=]
"
DEPEND="
	${RDEPEND}
"
BDEPEND=""

IUSE="+network +concurrent test"
