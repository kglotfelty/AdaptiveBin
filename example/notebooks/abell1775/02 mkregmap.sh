cd 13510

punlearn mkregmap
plist mkregmap
/bin/rm -rf mkregmap
mkdir mkregmap

get_sky_limits img.fits 

time mkregmap \
  infile=img.fits \
  outfile=mkregmap/rgrid.map \
  binimg=mkregmap/rgrid.img \
  regions="rgrid(3595.5:4460.5:50,3942.5:4800.5:50)" \
  clob+

aconvolve mkregmap/rgrid.map mkregmap/rgrid.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mkregmap/rgrid.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask mkregmap/rgrid.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  mkregmap/rgrid.map -scale linear \
  -region delete all \
  -mask color black -mask mkregmap/rgrid.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png mkregmap/rgrid.abin.png 

#display < mkregmap/rgrid.abin.png

punlearn dmstat
dmstat img.fits"[sky=circle(4024,4232,100)]" cen+ clip+

time mkregmap \
  infile=img.fits \
  outfile=mkregmap/pgrid.map \
  binimg=mkregmap/pgrid.img \
  regions="pgrid(4023,4223,0:1000:50,0:360:30)" \
  clob+

aconvolve mkregmap/pgrid.map mkregmap/pgrid.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mkregmap/pgrid.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask mkregmap/pgrid.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  mkregmap/pgrid.map -scale linear \
  -region delete all \
  -mask color black -mask mkregmap/pgrid.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png mkregmap/pgrid.abin.png 

#display < mkregmap/pgrid.abin.png

punlearn dmellipse
dmellipse \
  infile=img.fits \
  outfile=mkregmap/ellipses.reg \
  fraction="lgrid(0.05:0.951:0.05)" \
  step=100 \
  x_cen=4023 y_cen=4223 fix_cen+ \
  mode=h clob+

dmlist mkregmap/ellipses.reg counts

time mkregmap \
  infile=img.fits \
  outfile=mkregmap/ellipse.map \
  binimg=mkregmap/ellipse.img \
  regions="region(mkregmap/ellipses.reg[#row=igrid(1:19:1)])" \
  clob+

aconvolve mkregmap/ellipse.map mkregmap/ellipse.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mkregmap/ellipse.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask mkregmap/ellipse.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  mkregmap/ellipse.map -scale linear \
  -region delete all \
  -mask color black -mask mkregmap/ellipse.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png mkregmap/ellipse.abin.png 

#display < mkregmap/ellipse.abin.png

aconvolve img.fits mkregmap/img.sm "lib:gaus(2,5,1,9,9)" method=slide edge=const const=0 clob+


dmstat mkregmap/img.sm cen- sig- med-

dmcontour mkregmap/img.sm \
  levels=1.3,1.2,1.1,1.0,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1 \
  out=mkregmap/contour.reg \
  clob+ mode=h

dmstat mkregmap/contour.reg"[cols component]" 

time mkregmap \
  infile=img.fits \
  outfile=mkregmap/contour.map \
  binimg=mkregmap/contour.img \
  regions="region(mkregmap/contour.reg[component=igrid(1:34:1)])" \
  clob+
  

aconvolve mkregmap/contour.map mkregmap/contour.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mkregmap/contour.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask mkregmap/contour.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  mkregmap/contour.map -scale linear \
  -region delete all \
  -mask color black -mask mkregmap/contour.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png mkregmap/contour.abin.png 

#display < mkregmap/contour.abin.png

cat << EOM > mkregmap/triangles.py

from region import polygon, CXCRegion
import numpy as np
from ciao_contrib.runtool import get_sky_limits
sidelen=50

get_sky_limits("img.fits")
xx,yy = get_sky_limits.xygrid.split(",")
x0,xN = [float(a) for a in xx.split(":")[:-1]]
y0,yN = [float(a) for a in yy.split(":")[:-1]]

num_x = int(np.ceil((xN-x0)/sidelen))
num_y = int(np.ceil((yN-y0)/sidelen))

tri_x = np.array([0.0, 1.0, 0.0])*sidelen
tri_y = np.array([0.0, 0.0, 1.0])*sidelen

utri_x = np.array([0.0, 1.0, 1.0])*sidelen
utri_y = np.array([1.0, 1.0, 0.0])*sidelen

outreg = CXCRegion()
for yy in range(num_y):
    for xx in range(num_x):
        outreg = outreg + polygon(tri_x+xx*sidelen+x0, tri_y+yy*sidelen+y0)
        outreg = outreg + polygon(utri_x+xx*sidelen+x0, utri_y+yy*sidelen+y0)        

outreg.write("mkregmap/mypoly.reg", newline=True, clobber=True)
EOM

python mkregmap/triangles.py

time mkregmap \
  infile=img.fits \
  outfile=mkregmap/triangle.map \
  binimg=mkregmap/triangle.img \
  regions="@-mkregmap/mypoly.reg" \
  clob+
  

aconvolve mkregmap/triangle.map mkregmap/triangle.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mkregmap/triangle.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask mkregmap/triangle.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  mkregmap/triangle.map -scale linear \
  -region delete all \
  -mask color black -mask mkregmap/triangle.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png mkregmap/triangle.abin.png 

#display < mkregmap/triangle.abin.png


