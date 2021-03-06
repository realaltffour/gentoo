# Copyright 2001-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils qmake-utils subversion xdg-utils

MY_P=${PN}-${PV%0}-src

DESCRIPTION="Qt5 application to design electric diagrams"
HOMEPAGE="https://qelectrotech.org/"
ESVN_REPO_URI="svn://svn.tuxfamily.org/svnroot/qet/qet/trunk"

LICENSE="CC-BY-3.0 GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

S=${WORKDIR}/${MY_P}

DOCS=( CREDIT ChangeLog README )
PATCHES=( "${FILESDIR}/${PN}-0.3-fix-paths.patch" )

src_configure() {
	eqmake5 ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	einstalldocs

	if use doc; then
		doxygen Doxyfile || die
		dodoc -r doc/html
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
