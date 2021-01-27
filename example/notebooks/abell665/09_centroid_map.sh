punlearn centroid_map
plist centroid_map


centroid_map abell665.flux.asm \
   centroid.map numiter=20 clob+

dmmaskbin abell665.flux.asm centroid.map centroid.img clob+

###map2reg centroid.map centroid.reg clob+
aconvolve centroid.map centroid.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 centroid.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask centroid.grad -nomask \
    centroid.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask centroid.grad -nomask \
    -saveimage png centroid.png 

#display < centroid.png



plist statmap

python << EOM
import region
import stk
o=region.field()
for r in stk.build("@s.reg"):
   o=o-region.CXCRegion(r)
o.write("exld.reg",fits=True,clobber=True)
EOM

statmap "acisf13201_repro_evt2.fits[energy=500:7000][sky=region(exld.reg)]" centroid.map median_energy.map clob+


#ds9 median_energy.map




