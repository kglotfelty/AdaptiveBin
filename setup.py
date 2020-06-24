

import os
import sys

assert "ASCDS_INSTALL" in os.environ, "Please run this after CIAO has been setup"


scripts = ["contour_map","dragon_scales","vtbin","hexgrid","mkregmap","pathfinder",
            "centroid_map", "merge_too_small", "map2reg"]
params = [ x+".par" for x in scripts]
docs = [ x+".xml" for x in scripts if os.path.exists(x+".xml")]


from setuptools import setup
from setuptools.command.install import install


class InstallAhelpWrapper(install):
    'A simple wrapper to run ahelp -r after install to update ahelp index'

    @staticmethod
    def update_ahelp_database():
        print("Update ahelp database ...")
        from subprocess import check_output
        sout = check_output(["ahelp","-r"])
        for line in sout.decode().split("\n"):
            for summary in ["Processed", "Succeeded", "Failed", "Purged"]:
                if line.startswith(summary):
                    print("    "+line)

    
    def run(self):
        install.run(self)
        self.update_ahelp_database()


setup( name='AdaptiveBin',
        version='0.9.0',
        description='Adaptive binning scripts',
        author='Ken Glotfelty',
        author_email='kglotfelty@cfa.harvard.edu',
        url='https://github.com/kglotfelty/AdaptiveBin/',
        scripts = scripts,
        data_files = [ ("param", params ), ("share/doc/xml", docs ) ],
        packages=["crates_contrib",],
        cmdclass={'install': InstallAhelpWrapper},
        
        )
