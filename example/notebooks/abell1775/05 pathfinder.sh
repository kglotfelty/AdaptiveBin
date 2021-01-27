cd 13510

punlearn pathfinder
plist pathfinder
/bin/rm -rf pathfinder
mkdir pathfinder

aconvolve img.fits pathfinder/img.sm "lib:gaus(2,5,5,5,5)" meth=slide edge=const const=0 clob+

time pathfinder \
  infile=pathfinder/img.sm \
  outfile=pathfinder/pf.map \
  minval=0.1 \
  direction=diagonal \
  debugreg=pathfinder/pf.reg\
  mode=h clob+

aconvolve pathfinder/pf.map pathfinder/pf.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

dmmaskbin pathfinder/img.sm pathfinder/pf.map pathfinder/pf.img clob+ 

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  pathfinder/pf.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask pathfinder/pf.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  pathfinder/pf.map -scale linear \
  -region delete all \
  -mask color black -mask pathfinder/pf.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png pathfinder/pf.abin.png 

#display < pathfinder/pf.abin.png

ds9  \
  -view colorbar no -view info no -view panner no -view magnifier no \
  pathfinder/img.sm -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask pathfinder/pf.grad -nomask \
  -region select all -region color black -region select none \
  -saveimage png pathfinder/img.sm.pf.png 

#display < pathfinder/img.sm.pf.png


punlearn dmimgadapt
dmimgadapt \
  img.fits pathfinder/pf.asm \
  gaus 1 30 60 linear counts=100 \
  mode=h clob+

time pathfinder \
  infile=pathfinder/pf.asm \
  outfile=pathfinder/pf.asm.map \
  minval=0.1 \
  direction=diagonal \
  mode=h clob+

aconvolve pathfinder/pf.asm.map pathfinder/pf.asm.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

dmmaskbin pathfinder/img.sm pathfinder/pf.asm.map pathfinder/pf.asm.img clob+ 

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  pathfinder/pf.asm.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask pathfinder/pf.asm.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  pathfinder/pf.asm.map -scale linear \
  -region delete all \
  -mask color black -mask pathfinder/pf.asm.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png pathfinder/pf.asm.abin.png 

#display < pathfinder/pf.asm.abin.png

ds9  \
  -view colorbar no -view info no -view panner no -view magnifier no \
  pathfinder/pf.asm -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask pathfinder/pf.asm.grad -nomask \
  -region select all -region color black -region select none \
  -saveimage png pathfinder/pf.asm.pf.png 

#display < pathfinder/pf.asm.pf.png



