date

ciaover 

download_chandra_obsid 13201 evt1,asol,bpix,flt,fov,msk,mtl,stat,pbk,dtf,bias

chandra_repro 13201 out=./

fluximage acisf13201_repro_evt2.fits"[ccd_id=0:3]" out=abell665 band=broad bin=2 clob+ psfecf=0.9

curl -O http://soliton.vm.bytemark.co.uk/pub/cpt-city/neota/othr/sunset-in-atlantis.sao

ds9 abell665_broad_thresh.img -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -saveimage png ds9_01.png 

#display < ds9_01.png

punlearn wavdetect wrecon wtransform

pset wavdetect \
  infile=abell665_broad_thresh.img \
  outfile=abell665.src \
  scell=abell665.cell \
  imagef=abell665.recon \
  defn=abell665.nbkg \
  scales="1.4 2 4 8 12 16 24" \
  psffile=abell665_broad_thresh.psfmap \
  expfile=abell665_broad_thresh.expmap \
  clob+

wavdetect mode=h

ds9 abell665_broad_thresh.img -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -regions load abell665.src \
    -saveimage png ds9_02.png 

#display < ds9_02.png

aconvolve abell665_broad_thresh.img - "lib:gaus(2,5,5,5,5)" meth=slide edge=const const=0 | \
dmimgfilt - bkg.img median "annulus(0,0,20,22)" mode=h clob+

dmimglasso bkg.img cluster.reg xpos=4096 ypos=4096 coord=phys low=0.34 hi=INDEF max=1000000 clob+

ds9 bkg.img -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -regions load cluster.reg \
    -saveimage png ds9_03.png 

#display < ds9_03.png

dmcopy "abell665.src[exclude (x,y)=region(cluster.reg)]" srcs_2_fill.reg clob+

ds9 abell665_broad_thresh.img -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -regions load srcs_2_fill.reg \
    -saveimage png ds9_04.png 

#display < ds9_04.png

/bin/rm -rf roi 
mkdir -p roi

roi \
  infile= srcs_2_fill.reg \
  fovreg="region(acisf13201_repro_fov1.fits)" \
  outsrc=roi/src_%04d.reg \
  radiusmode=mul bkgrad=3 \
  group=individual targetbkg=target \
  bkgfactor=1 \
  mode=h clob+

/bin/ls roi/sr*reg | sed "s,.*,region(&)," > s.reg
/bin/ls roi/sr*reg | sed "s,.*,region(&[bkgreg])," > b.reg

dmfilth abell665_broad_thresh.img \
  out=abell665_xfill.img \
  src=@-s.reg \
  bkg=@-b.reg \
  method=POISSON \
  mode=h clob+

ds9 abell665_xfill.img -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -saveimage png ds9_05.png 

#display < ds9_05.png

# We need to be sure the subspace has FOV boundary 

dmcopy abell665_xfill.img"[sky=region(acisf13201_repro_fov1.fits[ccd_id=0:3])][opt full]" \
  abell665_fill.img clob+

dmimgadapt abell665_fill.img abell665_fill.asm \
  gaus min=0.5 max=25 numrad=50 radscal=line counts=49 \
  mode=h clob+ radfile=abell665_fill.asm.radii

ds9 abell665_fill.asm -scale log -scale limits 0 150 -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -saveimage png abell665_fill.asm.png 

#display < abell665_fill.asm.png

dmimgcalc abell665_fill.asm.radii none unit.img op="imgout=((img1-img1)+1)" clob+

dmimgadapt abell665_broad_thresh.expmap abell665.expmap.asm \
  gaus min=0.5 max=25 numrad=50 radscal=line counts=49 \
  mode=h clob+ inradfile=abell665_fill.asm.radii \
  innorm=unit.img 

dmimgcalc abell665_fill.asm abell665.expmap.asm - div | \
  dmcopy "-[sky=region(acisf13201_repro_fov1.fits[ccd_id=0:3])][opt full]" abell665.flux.asm clob+

ds9 abell665.flux.asm -scale log -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -saveimage png abell665.flux.asm.png 

#display < abell665.flux.asm.png

aconvolve  abell665_fill.img sm.img "lib:gaus(2,5,5,9,9)" met=slide edge=cons const=0 clob+
aconvolve  abell665_broad_thresh.expmap sm.exp "lib:gaus(2,5,5,9,9)" met=slide edge=cons const=0 clob+
dmimgcalc sm.img sm.exp - div lookup="" | \
  dmcopy "-[sky=region(acisf13201_repro_fov1.fits[ccd_id=0:3])][opt full]" sm.flux clob+


ds9 sm.flux -scale log -block to 3 \
    -cmap load sunset-in-atlantis.sao \
    -saveimage png sm.flux.png 

#display < sm.flux.png










