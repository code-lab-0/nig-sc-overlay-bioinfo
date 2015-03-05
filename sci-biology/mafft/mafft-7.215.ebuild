# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-7.050.ebuild,v 1.2 2013/07/19 09:44:31 jlec Exp $

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs

EXTENSIONS="-without-extensions"

DESCRIPTION="Multiple sequence alignments using a variety of algorithms"
HOMEPAGE="http://mafft.cbrc.jp/alignment/software/index.html"
SRC_URI="http://mafft.cbrc.jp/alignment/software/${P}${EXTENSIONS}-src.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="threads"

S="${WORKDIR}"/${P}${EXTENSIONS}

src_compile() {
	pushd core > /dev/null || die
	emake \
		$(usex threads ENABLE_MULTITHREAD="-Denablemultithread" ENABLE_MULTITHREAD="") \
		PREFIX="${EPREFIX}"/usr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}"
	popd > /dev/null || die
}

src_install() {
	pushd core
	emake PREFIX="${ED}usr" install
	popd
	dodoc readme
}
