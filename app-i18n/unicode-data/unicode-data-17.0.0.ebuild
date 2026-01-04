# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Unicode data from unicode.org"
HOMEPAGE="https://unicode.org/ucd/"
SRC_URI="
https://unicode.org/Public/17.0.0/ucd/UCD.zip -> unicode-data-17.0.0-UCD.zip
https://unicode.org/Public/17.0.0/ucd/Unihan.zip -> unicode-data-17.0.0-Unihan.zip"
LICENSE="unicode"
SLOT="0"
KEYWORDS="*"
DEPEND="app-arch/unzip
	
"
S="${WORKDIR}"
src_unpack() {
	  # Unihan.zip needs to be installed as a zip for reverse deps
	  unpack ${P}-UCD.zip
}
src_install() {
	  insinto /usr/share/${PN}
	  doins -r "${S}"/*
	  newins "${DISTDIR}"/${P}-Unihan.zip Unihan.zip
}


# vim: filetype=ebuild
