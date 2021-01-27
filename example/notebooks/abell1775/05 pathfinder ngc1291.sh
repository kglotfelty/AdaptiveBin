/bin/rm -rf 11272
download_chandra_obsid 11272 evt2,asol,msk,bpix 

cd 11272

curl -O http://soliton.vm.bytemark.co.uk/pub/cpt-city/neota/othr/sunset-in-atlantis.sao

download_obsid_caldb "./primary/*evt2.fits.gz" out=./CALDB

source CALDB/config/caldbinit-4.9.4.sh

merge_obs "./primary/*evt2.fits.gz[ccd_id=7]" out=mo/ngc1291 bin=1 psfecf=0.9 clob+ clean-

# ds9 mo/ngc1291_broad_thresh.img

aconvolve mo/ngc1291_broad_thresh.img mo/img.sm "lib:gaus(2,5,5,3,3)" meth=slide edge=const const=0 clob+

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mo/img.sm -scale log \
  -pan to 03:17:18.6 -41:06:28.4 fk5 \
  -cmap load sunset-in-atlantis.sao \
  -saveimage png mo/ngc1291.sm.png 

#display < mo/ngc1291.sm.png
  

punlearn pathfinder
plist pathfinder
/bin/rm -rf pathfinder
mkdir pathfinder

time pathfinder \
  infile=mo/img.sm \
  outfile=pathfinder/ngc1291.map \
  minval=0.1 \
  debugreg=pathfinder/ngc1291.reg \
  clob+

aconvolve pathfinder/ngc1291.map pathfinder/ngc1291.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

dmmaskbin mo/img.sm pathfinder/ngc1291.map pathfinder/ngc1291.img clob+ 

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  pathfinder/ngc1291.img -scale log \
  -pan to 03:17:18.6 -41:06:28.4 fk5 \
  -cmap load sunset-in-atlantis.sao \
  -mask color black -mask pathfinder/ngc1291.grad -nomask \
  -block to 2 \
  pathfinder/ngc1291.map -scale linear \
  -pan to 03:17:18.6 -41:06:28.4 fk5 \
  -region delete all \
  -mask color black -mask pathfinder/ngc1291.grad -nomask \
  -cmap load $ASCDS_CONTRIB/data/16_ramps.lut \
  -block to 1 -zoom to 0.5 \
  -tile column \
  -saveimage png pathfinder/ngc1291.abin.png 

#display < pathfinder/ngc1291.abin.png

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mo/img.sm -scale log \
  -cmap load sunset-in-atlantis.sao \
  -mask color forestgreen -mask pathfinder/ngc1291.grad -nomask \
  -zoom to 4 \
  -pan to 03:17:18.6 -41:06:28.4 fk5 \
  -saveimage png pathfinder/ngc1291.overlay.png 

#display < pathfinder/ngc1291.overlay.png
  

ds9 -geometry 900x600 \
  -view colorbar no -view info no -view panner no -view magnifier no \
  mo/img.sm -scale log \
  -pan to 03:17:18.6 -41:06:28.4 fk5 \
  -cmap load sunset-in-atlantis.sao \
  -region pathfinder/ngc1291.reg -region select all -region color white -region select none \
  -zoom to 4 \
  -saveimage png pathfinder/ngc1291.path.png 

#display < pathfinder/ngc1291.path.png
  


