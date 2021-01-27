punlearn pathfinder
plist pathfinder

/bin/rm -rf pathfinder
mkdir pathfinder
pathfinder infile=abell665.flux.asm outfile=pathfinder/path.map clob+

merge_too_small pathfinder/path.map pathfinder/path_min20px.map meth=area minval=30 clob+

merge_too_small  pathfinder/path_min20px.map  pathfinder/path_min20px50ts.map \
  method=counts imgfile=abell665_fill.img min=50 clob+

dmmaskbin abell665.flux.asm pathfinder/path_min20px50ts.map pathfinder/path.img clob+

### map2reg pathfinder/path.map pathfinder/path.reg
aconvolve pathfinder/path_min20px50ts.map pathfinder/path.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 pathfinder/path.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask pathfinder/path.grad -nomask \
    pathfinder/path_min20px50ts.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask pathfinder/path.grad -nomask \
    -saveimage png pathfinder/path.png 

#display < pathfinder/path.png



merge_too_small  pathfinder/path_min20px.map  pathfinder/path_min20px250ts.map \
  method=counts imgfile=abell665_fill.img min=250 clob+

dmmaskbin abell665.flux.asm pathfinder/path_min20px250ts.map pathfinder/path250.img clob+

### map2reg pathfinder/path.map pathfinder/path.reg
aconvolve pathfinder/path_min20px250ts.map pathfinder/path250.grad "txt:((1,1,1),(1,-8,1),(1,1,1))" meth=slide edge=const const=0 norm=none clob+

ds9 -geometry 1500x800 pathfinder/path250.img -scale log -block to 2 -scale limits 0 2e-6 \
    -cmap load sunset-in-atlantis.sao \
    -mask color black -mask pathfinder/path250.grad -nomask \
    pathfinder/path_min20px250ts.map -scale linear -scale mode minmax -zoom to 0.5 -block to 1 \
    -cmap load $ASCDS_INSTALL/contrib/data/16_ramps.lut \
    -view info no -view panner no -view magnifier no -view buttons no -view colorbar no \
    -mask color black -mask pathfinder/path250.grad -nomask \
    -saveimage png pathfinder/path.png 

#display < pathfinder/path.png


