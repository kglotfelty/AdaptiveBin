ciaover -v

/bin/rm -rf 13510

download_chandra_obsid 13510 evt1,asol,bpix,bias,dtf,flt,fov,msk,mtl,pbk,stat

cd 13510

download_obsid_caldb ./secondary/acisf13510_001N002_evt1.fits.gz out=./CALDB clob+

source ./CALDB/software/tools/caldbinit.sh

chandra_repro . ./repro clob+

fluximage repro/acisf13510_repro_evt2.fits"[ccd_id=7]" bin=1 band=broad psfecf=0.9 out=fimg/abell1775

/bin/ls fimg/*

# Grab a nice custom color map
curl -O http://soliton.vm.bytemark.co.uk/pub/cpt-city/neota/othr/sunset-in-atlantis.sao

ds9 fimg/abell1775_broad_thresh.img \
  -cmap load sunset-in-atlantis.sao \
  -scale log -block to 3 \
  -saveimage png fimg/abell1775_broad_thresh.img.png 

#display < fimg/abell1775_broad_thresh.img.png 

/bin/rm -rf points
mkdir points

punlearn celldetect
celldetect \
  infile=fimg/abell1775_broad_thresh.img \
  expstk=fimg/abell1775_broad_thresh.expmap \
  psffil=fimg/abell1775_broad_thresh.psfmap \
  outfile=points/cell.src thresh=2.7 mode=h clob+

### ds9 fimg/abell1775_broad_thresh.img -region points/cell.src 

/bin/rm -f points/points*reg
punlearn roi
roi \
  infile=points/cell.src \
  outsrc=points/points_%03d.reg \
  group=individual target=target \
  mode=h clob+ compute_conf=no 

# Create lists for source and background regions, could also use `splitroi`
/bin/ls points/*reg | sed "s@.*@region(&[srcreg])@" > points/src.lis
/bin/ls points/*reg | sed "s@.*@region(&[bkgreg])@" > points/bkg.lis

# Fill in the holes

punlearn dmfilth
dmfilth fimg/abell1775_broad_thresh.img \
  outfile=fimg/abell1775_broad_thresh.img.fill \
  method=POIS \
  src=@-points/src.lis \
  bkg=@-points/bkg.lis \
  randseed=1010 \
  mode=h clob+ 

### ds9 fimg/abell1775_broad_thresh.img.fill

punlearn skyfov
skyfov fimg/abell1775_broad_flux.img out=fimg/my.fov \
  msk=secondary/acisf13510_001N002_msk1.fits clob+\
  method=convex aspect=repro/pcadf13510_repro_asol1.fits
dmcopy fimg/my.fov"[ccd_id=7]" fimg/my7.fov clob+

ds9 fimg/abell1775_broad_thresh.img.fill \
  -cmap load sunset-in-atlantis.sao \
  -scale log -block to 3 \
  -region fimg/my7.fov \
  -saveimage png fimg/abell1775_broad_thresh.img.fill.png 

#display < fimg/abell1775_broad_thresh.img.fill.png 

# This is NOT a great algorithm for finding a box that inscribes a polygon
# but it works OK for this example.

python << EOM
from pycrates import read_file
tab = read_file("fimg/my7.fov")
xx = tab.get_column("x").values
yy = tab.get_column("y").values
npts=xx.shape[1]

xx = xx.reshape([npts])[0:npts-1]
yy = yy.reshape([npts])[0:npts-1]

mx = sum(xx)/(npts-1)
my = sum(yy)/(npts-1)

xx = xx - mx
yy = yy - my

xl = max(xx[xx<0])+mx
xh = min(xx[xx>0])+mx

yl = max(yy[yy<0])+my
yh = min(yy[yy>0])+my

print(f"[bin x={xl:.6}:{xh:.6}:1,y={yl:.6}:{yh:.6}:1]")

EOM


/bin/ls fimg/* | egrep -v 'png|crop|fov'  | \
  xargs -I@ dmcopy @"[bin x=3595.51:4460.01:1,y=3942.71:4800.01:1]" @_crop clob+

### ds9 fimg/abell1775_broad_thresh.img.fill_crop fimg/abell1775_broad_thresh.img.fill

dmcopy fimg/abell1775_broad_thresh.img.fill_crop img.fits clob+


