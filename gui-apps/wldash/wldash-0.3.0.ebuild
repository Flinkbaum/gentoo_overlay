# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
ab_glyph_rasterizer-0.1.4
alsa-0.4.3
alsa-sys-0.3.1
autocfg-1.0.1
bitflags-1.2.1
block-buffer-0.7.3
block-padding-0.1.5
byte-tools-0.3.1
byteorder-1.4.2
cc-1.0.66
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
const-cstr-0.3.0
dbus-0.6.5
digest-0.8.1
dlib-0.4.2
dlib-0.5.0
downcast-rs-1.2.0
dtoa-0.4.7
either-1.6.1
fake-simd-0.1.2
fontconfig-0.2.0
fuzzy-matcher-0.3.7
generic-array-0.12.3
itertools-0.10.3
itoa-0.4.7
lazy_static-1.4.0
libc-0.2.86
libdbus-sys-0.2.1
libloading-0.6.7
libloading-0.7.3
libpulse-binding-2.23.0
libpulse-sys-1.18.0
linked-hash-map-0.5.4
maplit-1.0.2
memmap-0.7.0
multimap-0.8.2
nix-0.15.0
nix-0.16.1
nix-0.18.0
num-bigint-0.2.6
num-complex-0.2.4
num-derive-0.3.3
num-integer-0.1.44
num-rational-0.2.4
num-traits-0.2.14
once_cell-1.5.2
opaque-debug-0.2.3
os_pipe-0.9.2
owned_ttf_parser-0.6.0
pest-2.1.3
pest_derive-2.1.0
pest_generator-2.1.3
pest_meta-2.1.3
pkg-config-0.3.19
proc-macro2-1.0.24
quote-1.0.9
rcalc_lib-0.9.3
rust-ini-0.14.0
rusttype-0.9.2
ryu-1.0.5
same-file-1.0.6
serde-1.0.123
serde_derive-1.0.123
serde_json-1.0.62
serde_yaml-0.8.17
sha-1-0.8.2
shlex-0.1.1
smallvec-1.6.1
syn-1.0.60
thread_local-1.1.3
time-0.1.44
timerfd-1.2.0
ttf-parser-0.6.2
typenum-1.12.0
ucd-trie-0.1.3
unicode-segmentation-1.7.1
unicode-xid-0.2.1
void-1.0.2
walkdir-2.3.2
wasi-0.10.0+wasi-snapshot-preview1
wayland-client-0.28.3
wayland-commons-0.28.3
wayland-protocols-0.28.3
wayland-scanner-0.28.3
wayland-sys-0.28.3
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xml-rs-0.8.3
yaml-rust-0.4.5
yeslogic-fontconfig-sys-2.11.1
"

inherit cargo

DESCRIPTION="A dashboard/launcher/control-panel thing for Wayland"
HOMEPAGE="https://sr.ht/~kennylevinsen/wldash/"
SRC_URI="https://git.sr.ht/~kennylevinsen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""
BDEPEND="${RDEPEND}
	virtual/pkgconfig
"
