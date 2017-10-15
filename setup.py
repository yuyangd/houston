#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from setuptools import setup, find_packages
import houston

requires = []

def setup_package():
    setup(
        name='houston',
        version=houston.__version__,
        description='The command line tool for cloud automation',
        url='https://github.com/duy156/houston',
        author='Du Yuyang',
        author_email='du.r.yuyang@gmail.com',
        scripts=['bin/stack'],
        install_requires=requires,
        packages=find_packages(exclude=['tests*']),
        classifiers=[
            'Development Status :: 5 - Production/Stable',
            'Intended Audience :: Developers',
            'Natural Language :: English',
            'License :: OSI Approved :: MIT License',
            'Operating System :: OS Independent',
            'Programming Language :: Python',
            'Programming Language :: Python :: 2',
            'Programming Language :: Python :: 2.6',
            'Programming Language :: Python :: 2.7',
            'Topic :: Software Development :: Libraries :: Python Modules',
        ],
    )


if __name__ == "__main__":
    setup_package()
