/bin/rm -rf dragon_scales
mkdir dragon_scales
cd dragon_scales

ln -s ../sunset-in-atlantis.sao ./
ln -s ../sm.flux ./



punlearn dragon_scales

plist dragon_scales

pget dragon_scales shape.p_min

dragon_scales sm.flux radius=30 outfile=dragon_30px.map binimg=dragon_30px.img shape=hex grad+ clob+

###map2reg dragon_30px.map dragon_30px.reg clob+
aconvolve dragon_30px.map dragon_30px.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 dragon_30px.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask dragon_30px.grad -frame new -tile -nomask \
     dragon_30px.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask dragon_30px.grad \
    -saveimage png dragon_10px.png 

#display < dragon_10px.png

plist merge_too_small


merge_too_small infile=dragon_30px.map outfile=dragon_min50cts.map \
  method=counts imgfile=../abell665_broad_thresh.img minvalue=150 verbose=1 clob+

plist dmmaskbin

dmmaskbin sm.flux dragon_min50cts.map dragon_min50cts.img clob+
aconvolve dragon_min50cts.map dragon_min50cts.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 dragon_min50cts.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask dragon_30px.grad -frame new -tile -nomask \
     dragon_min50cts.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask dragon_30px.grad \
    -saveimage png dragon_50cts.png 

#display < dragon_50cts.png

plist statmap

statmap "../acisf13201_repro_evt2.fits[energy=500:7000]" \
  dragon_min50cts.map counts.map col=time stat=count clob+ mode=h

ds9 counts.map

cd dragon_scales



