cd 13510

punlearn centroid_map
plist centroid_map
/bin/rm -rf centroid_map
mkdir centroid_map

aconvolve img.fits centroid_map/img.sm "lib:gaus(2,5,5,9,9)" meth=slide edge=const const=0 clob+

time centroid_map \
  infile=centroid_map/img.sm \
  outfile=centroid_map/cntrd.map \
  numiter=20 \
  mode=h clob+ verb=2   # verb=2 leaves debugging files
  

aconvolve centroid_map/cntrd.map centroid_map/cntrd.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

dmmaskbin img.fits centroid_map/cntrd.map centroid_map/cntrd.img clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  centroid_map/cntrd.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask centroid_map/cntrd.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  centroid_map/cntrd.map -scale linear \
  -region delete all \
  -mask color black -mask centroid_map/cntrd.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png centroid_map/cntrd.abin.png 

#display < centroid_map/cntrd.abin.png

#display < vtbin/vtbin.abin.png

ds9 -smooth -scale limits 0 0.01 -zoom to 0.5 \
  -view colorbar no \
  centroid_map/cntrd.map.i*  \
  -movie frame gif centroid_map/cntrd.gif \
  

#display < centroid_map/cntrd.gif





time centroid_map \
  infile=centroid_map/img.sm \
  outfile=centroid_map/sqrt.map \
  numiter=20 \
  scale=sqrt \
  mode=h clob+ verb=1
  

aconvolve centroid_map/sqrt.map centroid_map/sqrt.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

dmmaskbin img.fits centroid_map/sqrt.map centroid_map/sqrt.img clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  centroid_map/sqrt.img -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask centroid_map/sqrt.grad -nomask \
  -region select all -region color black -region select none \
  -block to 2 \
  centroid_map/sqrt.map -scale linear \
  -region delete all \
  -mask color black -mask centroid_map/sqrt.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png centroid_map/sqrt.abin.png 

#display < centroid_map/sqrt.abin.png




