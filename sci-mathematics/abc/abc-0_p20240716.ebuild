# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="System for sequential logic synthesis and formal verification"
HOMEPAGE="https://people.eecs.berkeley.edu/~alanmi/abc/
	https://github.com/berkeley-abc/abc/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/berkeley-abc/abc.git"
elif [[ ${PV} == *_p20240716 ]] ; then
	COMMIT=c7ac6be504aae8511a51e461e006058645f53eae
	SRC_URI="https://github.com/berkeley-abc/abc/archive/${COMMIT}.tar.gz
		-> ${P}.tar.gz"
	S="${WORKDIR}"/abc-${COMMIT}
	KEYWORDS="~amd64 ~x86"
else
	die "unsupported abc version, given: ${PV}"
fi

LICENSE="BSD"
SLOT="0"
IUSE="+readline +threads"

RDEPEND="readline? ( sys-libs/readline:= )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/abc-0_p20230313-libabc.patch )

src_compile() {
	local -a mymakeargs=(
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		LD="$(tc-getCXX)"
		ABC_MAKE_VERBOSE=1
		ABC_USE_NO_CUDD=1
		ABC_USE_NAMESPACE=abc
		ABC_USE_PIC=1
		$(usex readline "ABC_USE_READLINE=1" "ABC_USE_NO_READLINE=1")
		$(usex threads "ABC_USE_PTHREADS=1" "ABC_USE_NO_PTHREADS=1")
	)
	emake "${mymakeargs[@]}" libabc.so
	emake "${mymakeargs[@]}" abc
}

src_install() {
	exeinto /usr/bin
	doexe abc

	newlib.so libabc.so libabc.so.0
	dosym -r /usr/$(get_libdir)/libabc.so.0 /usr/$(get_libdir)/libabc.so

	local -a headers_to_install=(
		aig/aig/aig.h
		aig/gia/giaAig.h
		aig/gia/giaCSatP.h
		aig/gia/giaIiff.h
		aig/gia/gia.h
		aig/gia/giaNewBdd.h
		aig/gia/giaNewTt.h
		aig/gia/giaTransduction.h
		aig/hop/cudd2.h
		aig/hop/hop.h
		aig/ioa/ioa.h
		aig/ivy/attr.h
		aig/ivy/ivy.h
		aig/miniaig/abcOper.h
		aig/miniaig/minilut.h
		aig/miniaig/ndr.h
		aig/miniaig/miniaig.h
		aig/saig/saig.h
		base/abc/abcInt.h
		base/abc/abc.h
		base/acb/acb.h
		base/acb/acbPar.h
		base/acb/acbSets.h
		base/bac/bac.h
		base/bac/bacPrs.h
		base/cba/cba.h
		base/cba/cbaPrs.h
		base/cba/cbaTypes.h
		base/cmd/cmd.h
		base/cmd/cmdInt.h
		base/exor/exor.h
		base/io/ioInt.h
		base/io/ioAbc.h
		base/io/ioResub.h
		base/main/abcapis_old.h
		base/main/main.h
		base/main/mainInt.h
		base/main/abcapis.h
		base/pla/pla.h
		base/ver/ver.h
		base/wlc/wlc.h
		base/wln/wln.h
		bdd/bbr/bbr.h
		bdd/cas/cas.h
		bdd/cudd/cudd.h
		bdd/cudd/cuddInt.h
		bdd/dsd/dsd.h
		bdd/dsd/dsdInt.h
		bdd/epd/epd.h
		bdd/extrab/extraBdd.h
		bdd/llb/llb.h
		bdd/llb/llbInt.h
		bdd/mtr/mtr.h
		bdd/mtr/mtrInt.h
		bdd/reo/reo.h
		bool/bdc/bdc.h
		bool/bdc/bdcInt.h
		bool/dec/dec.h
		bool/deco/deco.h
		bool/kit/cloud.h
		bool/kit/kit.h
		bool/lucky/lucky.h
		bool/lucky/luckyInt.h
		bool/rpo/literal.h
		bool/rpo/rpo.h
		bool/rsb/rsb.h
		bool/rsb/rsbInt.h
		generic.h
		map/amap/amap.h
		map/amap/amapInt.h
		map/cov/cov.h
		map/cov/covInt.h
		map/fpga/fpga.h
		map/fpga/fpgaInt.h
		map/if/ifCount.h
		map/if/acd/ac_wrapper.h
		map/if/if.h
		map/mapper/mapper.h
		map/mapper/mapperInt.h
		map/mio/exp.h
		map/mio/mioInt.h
		map/mio/mio.h
		map/mpm/mpm.h
		map/mpm/mpmInt.h
		map/mpm/mpmMig.h
		map/scl/scl.h
		map/scl/sclCon.h
		map/scl/sclTime.h
		map/scl/sclLib.h
		map/scl/sclSize.h
		map/super/super.h
		map/super/superInt.h
		misc/avl/avl.h
		misc/bar/bar.h
		misc/bbl/bblif.h
		misc/bzlib/bzlib.h
		misc/bzlib/bzlib_private.h
		misc/espresso/espresso.h
		misc/espresso/main.h
		misc/espresso/mincov.h
		misc/espresso/mincov_int.h
		misc/espresso/sparse.h
		misc/espresso/sparse_int.h
		misc/espresso/util_old.h
		misc/extra/extra.h
		misc/hash/hash.h
		misc/hash/hashFlt.h
		misc/hash/hashGen.h
		misc/hash/hashInt.h
		misc/hash/hashPtr.h
		misc/mem/mem.h
		misc/mem/mem2.h
		misc/mvc/mvc.h
		misc/nm/nm.h
		misc/nm/nmInt.h
		misc/parse/parse.h
		misc/parse/parseInt.h
		misc/st/st.h
		misc/st/stmm.h
		misc/tim/tim.h
		misc/tim/timInt.h
		misc/util/abc_namespaces.h
		misc/util/utilCex.h
		misc/util/utilDouble.h
		misc/util/utilFloat.h
		misc/util/utilMem.h
		misc/util/utilNam.h
		misc/util/utilSignal.h
		misc/util/util_hack.h
		misc/util/abc_global.h
		misc/util/utilTruth.h
		misc/vec/vec.h
		misc/vec/vecAtt.h
		misc/vec/vecFlt.h
		misc/vec/vecHash.h
		misc/vec/vecHsh.h
		misc/vec/vecInt.h
		misc/vec/vecMem.h
		misc/vec/vecPtr.h
		misc/vec/vecQue.h
		misc/vec/vecSet.h
		misc/vec/vecStr.h
		misc/vec/vecVec.h
		misc/vec/vecWec.h
		misc/vec/vecBit.h
		misc/vec/vecWrd.h
		misc/zlib/crc32.h
		misc/zlib/deflate.h
		misc/zlib/gzguts.h
		misc/zlib/inffast.h
		misc/zlib/inffixed.h
		misc/zlib/inflate.h
		misc/zlib/inftrees.h
		misc/zlib/trees.h
		misc/zlib/zconf.h
		misc/zlib/zlib.h
		misc/zlib/zutil.h
		opt/cgt/cgt.h
		opt/cgt/cgtInt.h
		opt/csw/csw.h
		opt/csw/cswInt.h
		opt/cut/cut.h
		opt/cut/cutInt.h
		opt/cut/cutList.h
		opt/dar/dar.h
		opt/dar/darInt.h
		opt/dau/dau.h
		opt/dau/dauInt.h
		opt/dsc/dsc.h
		opt/fret/fretime.h
		opt/fsim/fsim.h
		opt/fsim/fsimInt.h
		opt/fxch/Fxch.h
		opt/fxu/fxu.h
		opt/fxu/fxuInt.h
		opt/lpk/lpk.h
		opt/lpk/lpkInt.h
		opt/mfs/mfs.h
		opt/mfs/mfsInt.h
		opt/nwk/ntlnwk.h
		opt/nwk/nwk.h
		opt/nwk/nwkMerge.h
		opt/res/res.h
		opt/res/resInt.h
		opt/ret/retInt.h
		opt/rwr/rwr.h
		opt/rwt/rwt.h
		opt/sbd/sbd.h
		opt/sbd/sbdInt.h
		opt/sfm/sfm.h
		opt/sfm/sfmInt.h
		opt/sim/sim.h
		phys/place/libhmetis.h
		phys/place/place_base.h
		phys/place/place_gordian.h
		phys/place/place_qpsolver.h
		proof/abs/abs.h
		proof/abs/absRef.h
		proof/abs/absRefJ.h
		proof/acec/acec.h
		proof/acec/acecInt.h
		proof/cec/cecInt.h
		proof/cec/cec.h
		proof/dch/dch.h
		proof/dch/dchInt.h
		proof/fra/fra.h
		proof/fraig/fraig.h
		proof/fraig/fraigInt.h
		proof/int/int.h
		proof/int/intInt.h
		proof/int2/int2.h
		proof/int2/int2Int.h
		proof/pdr/pdr.h
		proof/pdr/pdrInt.h
		proof/ssc/ssc.h
		proof/ssc/sscInt.h
		proof/ssw/sswInt.h
		proof/ssw/ssw.h
		sat/bmc/bmc.h
		sat/bsat/satClause.h
		sat/bsat/satMem.h
		sat/bsat/satProof2.h
		sat/bsat/satSolver.h
		sat/bsat/satSolver2.h
		sat/bsat/satSolver3.h
		sat/bsat/satStore.h
		sat/bsat/satTruth.h
		sat/bsat/satVec.h
		sat/bsat2/pstdint.h
		sat/bsat2/Alg.h
		sat/bsat2/Alloc.h
		sat/bsat2/Dimacs.h
		sat/bsat2/Heap.h
		sat/bsat2/IntTypes.h
		sat/bsat2/Map.h
		sat/bsat2/Options.h
		sat/bsat2/ParseUtils.h
		sat/bsat2/Queue.h
		sat/bsat2/SimpSolver.h
		sat/bsat2/Solver.h
		sat/bsat2/SolverTypes.h
		sat/bsat2/Sort.h
		sat/bsat2/System.h
		sat/bsat2/Vec.h
		sat/bsat2/XAlloc.h
		sat/cnf/cnf.h
		sat/csat/csat_apis.h
		sat/glucose/AbcGlucose.h
		sat/glucose/Alg.h
		sat/glucose/Alloc.h
		sat/glucose/BoundedQueue.h
		sat/glucose/Constants.h
		sat/glucose/Dimacs.h
		sat/glucose/Heap.h
		sat/glucose/IntTypes.h
		sat/glucose/Map.h
		sat/glucose/Options.h
		sat/glucose/ParseUtils.h
		sat/glucose/Queue.h
		sat/glucose/SimpSolver.h
		sat/glucose/Solver.h
		sat/glucose/SolverTypes.h
		sat/glucose/Sort.h
		sat/glucose/System.h
		sat/glucose/Vec.h
		sat/glucose/XAlloc.h
		sat/glucose/pstdint.h
		sat/glucose2/AbcGlucose2.h
		sat/glucose2/Alg.h
		sat/glucose2/Alloc.h
		sat/glucose2/BoundedQueue.h
		sat/glucose2/CGlucose.h
		sat/glucose2/CGlucoseCore.h
		sat/glucose2/Constants.h
		sat/glucose2/Dimacs.h
		sat/glucose2/Heap.h
		sat/glucose2/Heap2.h
		sat/glucose2/IntTypes.h
		sat/glucose2/Map.h
		sat/glucose2/Options.h
		sat/glucose2/ParseUtils.h
		sat/glucose2/Queue.h
		sat/glucose2/SimpSolver.h
		sat/glucose2/Solver.h
		sat/glucose2/SolverTypes.h
		sat/glucose2/Sort.h
		sat/glucose2/System.h
		sat/glucose2/Vec.h
		sat/glucose2/XAlloc.h
		sat/glucose2/pstdint.h
		sat/lsat/solver.h
		sat/msat/msat.h
		sat/msat/msatInt.h
		sat/proof/pr.h
		sat/psat/m114p.h
		sat/psat/m114p_types.h
		sat/satoko/act_clause.h
		sat/satoko/act_var.h
		sat/satoko/cdb.h
		sat/satoko/clause.h
		sat/satoko/satoko.h
		sat/satoko/solver.h
		sat/satoko/types.h
		sat/satoko/utils/b_queue.h
		sat/satoko/utils/heap.h
		sat/satoko/utils/mem.h
		sat/satoko/utils/misc.h
		sat/satoko/utils/sdbl.h
		sat/satoko/utils/sort.h
		sat/satoko/utils/vec/vec_char.h
		sat/satoko/utils/vec/vec_flt.h
		sat/satoko/utils/vec/vec_int.h
		sat/satoko/utils/vec/vec_sdbl.h
		sat/satoko/utils/vec/vec_uint.h
		sat/satoko/watch_list.h
		sat/xsat/xsat.h
		sat/xsat/xsatBQueue.h
		sat/xsat/xsatClause.h
		sat/xsat/xsatHeap.h
		sat/xsat/xsatMemory.h
		sat/xsat/xsatSolver.h
		sat/xsat/xsatUtils.h
		sat/xsat/xsatWatchList.h
	)

	cd src
	for x in ${headers_to_install[@]} ; do
		mkdir -p ${D}/usr/include/$(dirname $x)
		install -m 644 $x ${D}/usr/include/$x
	done
	cd ..

	dodoc README.md readmeaig
}
