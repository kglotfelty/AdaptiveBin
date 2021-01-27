#seq 9 | sed 's,.*,&e-9,' > lvs.lis
seq 9 | sed 's,.*,&e-8,' > lvs.lis
seq 9 | sed 's,.*,&e-7,' >> lvs.lis
seq 3 | sed 's,.*,&e-6,' >> lvs.lis

contour_map sm.flux contour_map.map binimg=contour_map.img dist=250 \
  maxcontour=125 clob+ mode=h levels="@lvs.lis" \
  verb=1
  

merge_too_small contour_map.map contour_map_min5px.map \
  meth=area min=25 clob+ img=sm.flux binimg=contour_map_min5px.img 

dmimgfilt contour_map_min5px.map - max "box(0,0,3,3)" numiter=3 | \
  dmimgfilt - zz min "box(0,0,3,3)" numiter=3  clob+


dmimgthresh zz - cut=INDEF out=0 | \
dmmaskbin "sm.flux" "-[opt type=i4]" - | \
dmcopy "-[sky=region(acisf13201_repro_fov1.fits[ccd_id=0:3])][opt full,null=nan]"  zz.img clob+

aconvolve zz zz.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 zz.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -nan black \
    -mask color black -mask zz.grad \
    -frame new -tile -nomask \
    zz -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask zz.grad \
    -saveimage png contour_map_min5px.png 

#display < contour_map_min5px.png




