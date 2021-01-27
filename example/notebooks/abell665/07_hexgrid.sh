punlearn hexgrid
plist hexgrid

dmstat abell665.flux.asm cen+ sig- med- 

ix=`stk_read_num ")dmstat.out_cntrd_log" 1 echo+`
iy=`stk_read_num ")dmstat.out_cntrd_log" 2 echo+`


echo $ix $iy

/bin/rm -rf hexgrid
mkdir hexgrid
hexgrid abell665.flux.asm  hexgrid/hex30px.map side=15 binimg=hexgrid/hex30px.img \
  xref=$ix yref=$iy clob+

###map2reg hexgrid/hex30px.map hexgrid/hex30px.reg clob+
aconvolve hexgrid/hex30px.map hexgrid/hex30px.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 hexgrid/hex30px.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask hexgrid/hex30px.grad -nomask \
    hexgrid/hex30px.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask hexgrid/hex30px.grad -nomask \
    -saveimage png hexgrid/hex30px.png 

#display < hexgrid/hex30px.png

hexgrid abell665.flux.asm  hexgrid/hex50px.map side=50 binimg=hexgrid/hex50px.img \
  xref=$ix yref=$iy clob+

###map2reg hexgrid/hex30px.map hexgrid/hex30px.reg clob+
aconvolve hexgrid/hex50px.map hexgrid/hex50px.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+



ds9 -geometry 1500x800 hexgrid/hex50px.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask hexgrid/hex50px.grad -nomask \
    hexgrid/hex50px.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask hexgrid/hex50px.grad -nomask \
    -saveimage png hexgrid/hex50px.png 

#display < hexgrid/hex50px.png


