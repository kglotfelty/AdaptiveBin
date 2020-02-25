

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


scripts = ["contour_map","dragon_scales","vtbin","hexgrid","mkregmap","pathfinder",
            "centroid_map", "merge_too_small", "map2reg"]
params = [ x+".par" for x in scripts]
docs = [ x+".xml" for x in scripts if os.path.exists(x+".xml")]


from distutils.core import setup
setup( name='AdaptiveBin',
        version='0.9.0',
        description='Adaptive binning scripts',
        author='Ken Glotfelty',
        author_email='kglotfelty@cfa.harvard.edu',
        url='https://github.com/kglotfelty/AdaptiveBin/',
        scripts = scripts,
        data_files = [ ("param", params ), ("share/doc/xml", docs ) ],
        py_modules=["masked_image_crate"]        
        )

