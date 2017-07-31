

import os
import sys

assert "ASCDS_INSTALL" in os.environ, "Please run this after CIAO has been setup"

#
# I need the pythonX.Y version for the purelib's.  Can't find a way 
# to pass in so that it gets picked up by setup.cfg so we just set
# and env variable and that works.
#

ver = sys.version_info
os.environ["PYVER"] = "python{}.{}".format(ver[0],ver[1])

###
### distutils replaces the shebang /usr/bin/env python with sys.executable.
### This doesn't work with CIAO where we need to run the wrapper  in 
### $ASCDS_INSTALL/bin instead of $ASCDS_INSTALL/ots/bin
###
### So, we change it before running setup()

sys.executable = os.path.join( os.environ["ASCDS_INSTALL"], "bin", "python"  )


scripts = ["contour_bin"]
params = [ x+".par" for x in scripts]
docs = [ x+".xml" for x in scripts if os.path.exists(x+".xml")]


from distutils.core import setup
setup( name='TemperatureMaps',
        version='0.0.1',
        description='Temperature maps scripts',
        author='Anonymous',
        author_email='WhoDat@cfa.harvard.edu',
        url='https://github.com/kglotfelty/TemperatureMaps/',
        scripts = scripts,
        data_files = [ ("param", params ), ("share/doc/xml", docs ) ]
        )

