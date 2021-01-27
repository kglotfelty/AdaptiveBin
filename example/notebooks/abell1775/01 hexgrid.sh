cd 13510

punlearn dmstat
dmstat img.fits"[sky=circle(4024,4232,100)]" cen+ clip+

# ds9 img.fits -region command "physical;circle  4023.1959782 4223.5639627 10"

punlearn hexgrid
plist hexgrid
/bin/rm -rf hexgrid
mkdir hexgrid

time hexgrid img.fits \
  outfile=hexgrid/hex25.map \
  binimg=hexgrid/hex25.img \
  sidelen=25 \
  xref=100 yref=93 clob+

aconvolve hexgrid/hex25.map hexgrid/hex25.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  hexgrid/hex25.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask hexgrid/hex25.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  hexgrid/hex25.map -scale linear \
  -region delete all \
  -mask color black -mask hexgrid/hex25.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png hexgrid/hex25.abin.png 

#display < hexgrid/hex25.abin.png


