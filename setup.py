

import os
import sys

assert "ASCDS_INSTALL" in os.environ, "Please run this after CIAO has been setup"


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
        packages=["crates_contrib",]        
        )
 
from subprocess import check_output
print("Update ahelp database ...")
sout = check_output("ahelp -r".split())
for line in sout.decode().split("\n"):
    for summary in ["Processed", "Succeeded", "Failed", "Purged"]:
        if line.startswith(summary):
            print("    "+line)
