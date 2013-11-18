pybdaq
======

This project provides an **unofficial**, **unsupported**, **third-party**
Python interface to Advantech DAQ hardware, in the form of a Cython wrapper for
their C++ SDK.

Supported Functionality
-----------------------

The entirety of the API has not yet been wrapped. Initial support is limited to
basic digital and analog I/O.

Installation
------------

### Advantech SDK

The first and essential step is to download and install the Advantech driver
and SDK for Linux. These can be tricky to find, but are in fact [available from
the Advantech
site](http://support.advantech.com.tw/Support/DownloadSRDetail_New.aspx?SR_ID=1-LXHFQJ&Doc_Source=Download).

This library has been most recently tested with
`linux_driver_package_3.1.7.0_64bit.zip`. After downloading and extracting this
package, install the following packages inside the "drivers" and "SDK"
directories:

* biokernbase-dkms
* bio&lt;device&gt; (where &lt;device&gt is, e.g., "4704")
* libbio<device>
* libbiodaq

On a Debian-based OS, the typical installation method is `sudo dpkg -i`.

### Library

After installing the Advantech software, installation of this Python library
should be straightforward using pip and PyPI:

```sh
pip install pybdaq
```

As usual, the use of a virtualenv is strongly recommended.

Credits
-------

This library is developed by [Angaza Design](http://www.angazadesign.com).

License
-------

This software package is provided under the non-copyleft open-source "MIT"
license. The complete legal notice can be found in the included LICENSE file.
