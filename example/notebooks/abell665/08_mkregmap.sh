punlearn dmellipse
plist dmellipse

dmellipse abell665.flux.asm \
  ellipse.reg fraction=lgrid"(0.025:1.0:0.025)" \
  step=500 clob+ verb=2 \
  x_cen="4011.5" y_cen="4029.5" fix_cen-
  

dmlist ellipse.reg cols

dmsort ellipse.reg sort_ell.reg -fraction clob+
dmlist sort_ell.reg counts

punlearn mkregmap 
plist mkregmap

mkregmap infile=abell665.flux.asm \
  regions="region(ellipse.reg[#row=igrid(1:40:1)])" \
  outfile=ell.map binimg=ell.img clob+ 

aconvolve ell.map ell.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 ell.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask ell.grad -nomask \
    ell.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask ell.grad -nomask \
    -saveimage png ell.png 

#display < ell.png



#plist emodel

#emodel infile=sort_ell.reg  image= abell665.flux.asm out=emodel.img clob+ --debug

#ds9 -geometry 1500x800 \
#    abell665.flux.asm -scale log -block to 2 \
#    -cmap load sunset-in-atlantis.sao \
#    emodel.img \
#    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
#    -regions sort_ell.reg \
#    -regions select all -regions color black -regions select none  \
#    -saveimage png emodel.png 
#
#display < emodel.png

#dmstat emodel.img cen- sig- med-





get_sky_limits abell665.flux.asm

mkregmap infile=abell665.flux.asm \
  regions="rgrid(2656.5:5466.5:100,2850.5:5666.5:100)" \
  outfile=rgrid.map binimg=rgrid.img clob+ 
  
aconvolve rgrid.map rgrid.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 rgrid.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask rgrid.grad -nomask \
    rgrid.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask rgrid.grad -nomask \
    -saveimage png rgrid.png 

#display < rgrid.png

dmstat abell665.flux.asm cen+

mkregmap infile=abell665.flux.asm \
  regions="pgrid(4069.5,4021.5,0:1600:100,0:360:30)" \
  outfile=pgrid.map binimg=pgrid.img clob+ 
  
aconvolve pgrid.map pgrid.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 pgrid.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask pgrid.grad -nomask \
    pgrid.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask pgrid.grad -nomask \
    -saveimage png pgrid.png 

#display < pgrid.png

dmcontour abell665.flux.asm \
  levels=1e-6,8e-7,5e-7,4e-7,3e-7,2.5e-7,2e-7,1.5e-7,1e-7,8e-8,5e-8,4e-8,3e-8,2e-8,1e-8,5e-9,1e-9 \
  out=cntr.reg

dmstat cntr.reg"[cols component]" 


mkregmap infile=abell665.flux.asm \
  regions="region(cntr.reg[component=igrid(1:84:1)])" \
  outfile=cntr.map binimg=cntr.img clob+ 
  
aconvolve cntr.map cntr.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 cntr.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask cntr.grad -nomask \
    cntr.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask cntr.grad -nomask \
    -saveimage png cntr.png 

#display < cntr.png

# same thing w/ eg vtpdetect source regions (or any of the detect outputs)


