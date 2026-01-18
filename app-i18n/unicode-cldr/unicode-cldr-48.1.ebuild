# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Unicode Common Locale Data Repository"
HOMEPAGE="https://cldr.unicode.org/"
SRC_URI="https://unicode.org/Public/cldr/48.1/cldr-common-48.1.zip -> unicode-cldr-48.1.zip"
LICENSE="unicode"
SLOT="0"
KEYWORDS="*"
DEPEND="app-arch/unzip
	
"
S="${WORKDIR}"
src_install() {
	  insinto /usr/share/${PN/-//}
	  doins -r common
}


# vim: filetype=ebuild
