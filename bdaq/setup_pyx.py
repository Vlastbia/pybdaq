# -*- coding: utf-8 -*-
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

compiler_args = ["-std=gnu++0x",
#                 "-Werror",
                 "-Wno-uninitialized",
                 "-Wno-write-strings",
                 "-fpermissive"]

extensions = [
    Extension("wrapper_enums", ["wrapper_enums.pyx"],
              language='c++', 
              extra_compile_args=compiler_args),
    Extension("wrapper", ["wrapper.pyx"],
              language='c++', 
              extra_compile_args=compiler_args),
]
setup(
    name = "pybdaq_extensions",
    ext_modules = cythonize(extensions)
)