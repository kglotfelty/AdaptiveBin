plist vtbin

ls *flux*

/bin/rm -rf vtbin/
mkdir vtbin
vtbin infile=abell665.flux.asm outfile=vtbin/tess.map binimg=vtbin/tess.img clob+

### map2reg tess.map tess.reg clob+
aconvolve vtbin/tess.map vtbin/tess.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 vtbin/tess.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask vtbin/tess.grad -nomask \
    vtbin/tess.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask vtbin/tess.grad -nomask \
    -saveimage png tess.png 

#display < tess.png

vtbin infile=abell665.flux.asm outfile=vtbin/tess5.map binimg=vtbin/tess5.img clob+ radius=10

aconvolve vtbin/tess5.map vtbin/tess5.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 vtbin/tess5.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask vtbin/tess5.grad -nomask \
    vtbin/tess5.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask vtbin/tess5.grad -nomask \
    -saveimage png tess5.png 

#display < tess5.png


