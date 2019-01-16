#!/usr/bin/env python


from ciao_contrib.cipt import *
from sherpa.utils import parallel_map
from region import *

infile = "watershed.map"
outfile = "zzz0.fits"


img = CIAOImage(infile)
nmax = int(img.stats()["max"])


def get_region( n_at ):
    """
    """
    thrsh = img.thresh( n_at, n_at )
    pos = thrsh.stats()["max_loc"]
    logc = thrsh.physical( *pos )
    reg = thrsh.lasso( logc["logicalx"], logc["logicaly"], low_value=0.1, high_value=n_at+0.5, value="absolute", coord="logical" )
    return str(reg)


outreg = parallel_map( get_region, range(1,nmax+1) )



#allout = reduce( lambda x,y: region(x)+region(y), outreg )

allout = CXCRegion(outreg[0])
for r in outreg[1:]:
    allout = allout+CXCRegion(r)

allout.write( outfile, fits=True )



