cd 13510

punlearn contour_map
plist contour_map
/bin/rm -rf contour_map
mkdir contour_map

aconvolve img.fits contour_map/img.sm "lib:gaus(2,5,5,11,11)" method=slide edge=const const=0 clob+

time contour_map \
  infile=contour_map/img.sm \
  outfile=contour_map/cont.map \
  binimg=contour_map/cont.img \
  distance=500 shape=circle \
  levels=0.14,0.16,0.18,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.8,0.9,1.0,1.1,1.2,1.3 \
  maxcontours=75 \
  verb=1 clob+

aconvolve contour_map/cont.map contour_map/cont.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  contour_map/cont.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask contour_map/cont.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  contour_map/cont.map -scale linear \
  -region delete all \
  -mask color black -mask contour_map/cont.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png contour_map/cont.abin.png 

#display < contour_map/cont.abin.png












