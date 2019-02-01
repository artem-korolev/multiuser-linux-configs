#!/usr/bin/env python
# vim:fileencoding=utf-8:noet
from __future__ import unicode_literals
import os
import sys

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
try:
	README = open(os.path.join(here, 'README.rst'), 'rb').read().decode('utf-8')
except IOError:
	README = ''

old_python = sys.version_info < (2, 7)

setup(
	name='Powerline font patcher',
	version='beta',
	description='Font patcher script for Powerline.',
	long_description=README,
	classifiers=[],
	author='Kim Silkebaekken',
	author_email='kim.silkebaekken+vim@gmail.com',
	url='https://github.com/Lokaltog/powerline-fontpatcher',
	scripts=[
		'scripts/powerline-fontpatcher',
	],
	keywords='',
	packages=find_packages(exclude=('tests', 'tests.*')),
	include_package_data=True,
	zip_safe=False,
	install_requires=[],
	extras_require={
		'docs': [
			'Sphinx',
		],
	},
	test_suite='tests' if not old_python else None,
)
