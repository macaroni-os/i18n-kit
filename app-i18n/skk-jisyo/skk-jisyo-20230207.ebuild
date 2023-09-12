# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN=${PN^^}

DESCRIPTION="Jisyo (dictionary) files for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="https://github.com/skk-dev/dict/archive/1909dda026e6038975359a5eaeafcf50c9ce7fa3.tar.gz -> skk-jisyo-20230207.tar.gz"

LICENSE="CC-BY-SA-3.0 GPL-2+ public-domain unicode"
SLOT="0"
KEYWORDS="*"
IUSE="cdb"

DEPEND="app-alternatives/awk
	cdb? (
		|| (
			dev-db/tinycdb
			dev-db/cdb
		)
	)"
RDEPEND=""

DOCS=( ChangeLog{,.{1..3}} committers.md )
HTML_DOCS=( edict_doc.html )

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/dict-* "${S}"
}

src_prepare() {
	rm -f ${MY_PN}.{hukugougo,noregist,notes,pubdic+,requested,unannotated,*wrong*}

	default
}

cdb_make() {
	cdbmake "${1}" "${1}.tmp"
}

tinycdb_make() {
	cdb -c "${1}"
}

src_compile() {
	if use cdb; then
		local cdbmake=cdb_make f
		if has_version dev-db/tinycdb; then
			cdbmake=tinycdb_make
		fi
		for f in {,zipcode/}${MY_PN}.*; do
			LC_ALL=C awk '
				/^[^;]/ {
					s = substr($0, index($0, " ") + 1)
					print "+" length($1) "," length(s) ":" $1 "->" s
				}
				END {
					print ""
				}
			' ${f} | ${cdbmake} ${f}.cdb || die
		done
	fi
}

src_install() {
	insinto /usr/share/skk
	doins {,zipcode/}${MY_PN}.*

	einstalldocs
	docinto zipcode
	dodoc zipcode/README.md
}