cd 13510

punlearn dragon_scales
plist dragon_scales
/bin/rm -rf dragon_scales
mkdir dragon_scales

pget dragon_scales shape.p_min

aconvolve img.fits dragon_scales/img.sm "lib:gaus(2,5,5,3,3)" meth=slide edge=const const=0 clob+

time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/circle_20.map \
  binimg=dragon_scales/circle_20.img \
  shape=circle radius=20 \
  gradient- \
  clob+ mod=h

aconvolve dragon_scales/circle_20.map dragon_scales/circle_20.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/circle_20.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/circle_20.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/circle_20.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/circle_20.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/circle_20.abin.png 

#display < dragon_scales/circle_20.abin.png



punlearn dmimgadapt
dmimgadapt \
  img.fits \
  dragon_scales/asm500.img \
  tophat 10 40 60 linear counts=500 \
  radfile=dragon_scales/asm500.rad \
  clob+

time dragon_scales \
  infile=dragon_scales/asm500.img \
  outfile=dragon_scales/circle_map.map \
  binimg=dragon_scales/circle_map.img \
  shape=circle radius=dragon_scales/asm500.rad \
  gradient- \
  clob+ mod=h

aconvolve dragon_scales/circle_map.map dragon_scales/circle_map.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/circle_map.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/circle_map.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/circle_map.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/circle_map.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/circle_map.abin.png 

#display < dragon_scales/circle_map.abin.png



time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/box_40.map \
  binimg=dragon_scales/box_40.img \
  shape=box radius=40 \
  gradient=yes \
  clob+ mod=h
  
aconvolve dragon_scales/box_40.map dragon_scales/box_40.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/box_40.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/box_40.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/box_40.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/box_40.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/box_40.abin.png 

#display < dragon_scales/box_40.abin.png



time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/diamond_50.map \
  binimg=dragon_scales/diamond_50.img \
  shape=diamond radius=50 \
  gradient=yes \
  clob+ mod=h
  
aconvolve dragon_scales/diamond_50.map dragon_scales/diamond_50.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/diamond_50.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/diamond_50.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/diamond_50.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/diamond_50.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/diamond_50.abin.png 

#display < dragon_scales/diamond_50.abin.png



time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/hexagon_40.map \
  binimg=dragon_scales/hexagon_40.img \
  shape=hexagon radius=40 \
  gradient=yes \
  clob+ mod=h
  
aconvolve dragon_scales/hexagon_40.map dragon_scales/hexagon_40.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/hexagon_40.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/hexagon_40.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/hexagon_40.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/hexagon_40.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/hexagon_40.abin.png 

#display < dragon_scales/hexagon_40.abin.png



time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/triangle_120.map \
  binimg=dragon_scales/triangle_120.img \
  shape=triangle radius=120 \
  gradient=yes \
  clob+ mod=h
  
aconvolve dragon_scales/triangle_120.map dragon_scales/triangle_120.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/triangle_120.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/triangle_120.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/triangle_120.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/triangle_120.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/triangle_120.abin.png 

#display < dragon_scales/triangle_120.abin.png



time dragon_scales \
  infile=dragon_scales/img.sm \
  outfile=dragon_scales/itriangle_120.map \
  binimg=dragon_scales/itriangle_120.img \
  shape=itriangle radius=120 \
  gradient=yes \
  clob+ mod=h
  
aconvolve dragon_scales/itriangle_120.map dragon_scales/itriangle_120.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/itriangle_120.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/itriangle_120.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/itriangle_120.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/itriangle_120.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/itriangle_120.abin.png 

#display < dragon_scales/itriangle_120.abin.png





punlearn merge_too_small
plist merge_too_small

pget merge_too_small method.p_min

time merge_too_small \
  infile=dragon_scales/circle_20.map \
  outfile=dragon_scales/circle_20_min100cts.map \
  method=counts \
  imgfile=img.fits \
  binimg=dragon_scales/circle_20_min100cts.img \
  minval=100 \
  clob+

aconvolve dragon_scales/circle_20_min100cts.map dragon_scales/circle_20_min100cts.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  dragon_scales/circle_20_min100cts.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask dragon_scales/circle_20_min100cts.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  dragon_scales/circle_20_min100cts.map -scale linear \
  -region delete all \
  -mask color black -mask dragon_scales/circle_20_min100cts.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png dragon_scales/circle_20_min100cts.abin.png 

#display < dragon_scales/circle_20_min100cts.abin.png

plist statmap


dmcopy repro/acisf13510_repro_evt2.fits"[exclude sky=region(points/cell.src)]" points/src_free.evts clob+

statmap \
  infile=points/src_free.evts"[energy=500:7000,ccd_id=7]" \
  mapfile=dragon_scales/circle_20_min100cts.map \
  outfile=dragon_scales/min100cts.img \
  column=time statistic=count clob+

ds9 dragon_scales/min100cts.img -scale asinh \
  -zoom to 0.5 -colorbar space value -cmap viridis \
  -saveimage png dragon_scales/min100cts.img.png 

#display < dragon_scales/min100cts.img.png

dmstat dragon_scales/min100cts.img cen- sig- med- | egrep "min|max"


