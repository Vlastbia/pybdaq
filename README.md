pybdaq
======

This is a fork of the original pybdaq project created by angaza.
The main goal of this fork is to make it work on Windows.
bdaqctrl.h is taken from 'C:\Advantech\DAQNavi\Inc' following installation of the DAQNavi_SDK_3.2.3.0.exe

Description
-----------

This project provided an **unofficial**, **unsupported**, **third-party**
Python interface to Advantech DAQ hardware, in the form of a Cython wrapper for their C++ SDK.

Supported Functionality
-----------------------

The entirety of the API has not yet been wrapped. Initial support is limited to basic digital and analog I/O.

Installation
------------

### Advantech SDK

The first and essential step is to download and install the Advantech driver and SDK for Windows. The most recent version if the installer could be found (as of 2016/02/18) at http://downloadt.advantech.com/download/downloadsr.aspx?File_Id=1-129ZX71

### Library

After installing the Advantech software, installation of this Python library should be straightforward (Windows: TODO)
As usual, the use of a virtualenv is strongly recommended.

Credits
-------

This library has been developed largely by [Angaza Design](http://www.angazadesign.com),
but external contributions are welcome.

License
-------

This software package is provided under the non-copyleft open-source "MIT"
license. The complete legal notice can be found in the included LICENSE file.
