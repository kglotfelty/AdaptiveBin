cd 13510

punlearn vtbin
plist vtbin
/bin/rm -rf vtbin
mkdir vtbin

aconvolve img.fits vtbin/img.sm "lib:gaus(2,5,5,9,9)" meth=slide edge=const const=0 clob+

time vtbin \
  infile=vtbin/img.sm \
  outfile=vtbin/vtbin.map \
  binimg=vtbin/vtbin.img \
  mode=h clob+

aconvolve vtbin/vtbin.map vtbin/vtbin.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  vtbin/vtbin.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask vtbin/vtbin.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  vtbin/vtbin.map -scale linear \
  -region delete all \
  -mask color black -mask vtbin/vtbin.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png vtbin/vtbin.abin.png 

#display < vtbin/vtbin.abin.png

python << EOM 
infile="img.fits"
outfile="vtbin/random.dat"
npoints=250

from ciao_contrib.runtool import get_sky_limits
get_sky_limits(infile)
xx,yy = get_sky_limits.xygrid.split(",")
xl,xh = [float(a) for a in xx.split(":")[:-1]]
yl,yh = [float(a) for a in yy.split(":")[:-1]]

import numpy as np
np.random.seed(7773)
x_out=np.random.uniform(low=xl,high=xh,size=npoints)
y_out=np.random.uniform(low=yl,high=yh,size=npoints)

from crates_contrib.utils import write_arrays
write_arrays(outfile,[x_out,y_out],fields=["x","y"],clobber=True)

from ciao_contrib.runtool import dmcopy
dmcopy.infile = "{}[bin {}]".format(outfile,get_sky_limits.dmfilter)
dmcopy.outfile = outfile+".img"
dmcopy(clobber=True)

EOM


# dmimgcalc trick to copy wcs 
dmimgcalc img.fits vtbin/random.dat.img - add weight=0 weight2=1 | \
  dmimgblob - vtbin/random.sites 0.1 src+ clob+

time vtbin \
  infile=vtbin/img.sm \
  outfile=vtbin/sites.map \
  binimg=vtbin/sites.img \
  sitefile=vtbin/random.sites \
  mode=h clob+

aconvolve vtbin/sites.map vtbin/sites.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  vtbin/sites.img -scale log \
  -block to 2 \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask vtbin/sites.grad -nomask \
  -region select all -region color black -region select none \
  vtbin/sites.map -scale linear \
  -region delete all \
  -mask color black -mask vtbin/sites.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png vtbin/sites.abin.png 

#display < vtbin/sites.abin.png


