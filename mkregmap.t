#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

mkregmap in=$INDIR/img.fits \
  regions="pgrid(4262.2695791,3908.6296761,0:1000:50,0:360:15)" \
  out=$OUTDIR/reg_pie.map bin=$OUTDIR/reg_pie.img\
  clobber+

mkregmap in=$INDIR/img.fits \
  regions="$INDIR/tess.reg[component=igrid(1:1162:1)]" \
  out=$OUTDIR/reg_tess.map bin=$OUTDIR/reg_tess.img\
  clobber+




