# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

MYP=${PN}.py-${PV}

DESCRIPTION="Python wrappers to the symengine C++ library"
HOMEPAGE="https://github.com/symengine/symengine.py"
SRC_URI="https://github.com/symengine/symengine.py/archive/v${PV}.tar.gz -> ${MYP}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	>=sci-libs/symengine-0.5"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/sympy[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MYP}"

python_test() {
	cd "${BUILD_DIR}" || die
	nosetests -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_prepare_all
	python_optimize
	rm "${ED}"/usr/share/doc/${PF}/README.md || die
	newdoc README.md ${PN}.py.md
}
