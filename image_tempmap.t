#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

  
image_tempmap \
  infile="$INDIR/testsize*_thresh.img" \
  expfile="$INDIR/testsize*_thresh.expmap" \
  outfile=$OUTDIR/image_tempmap.fits \
  srcmodel="xswabs.absrb*xsapec.thrm" \
  initialization="set_method('levmar');absrb.nH = 0.0494;thrm.kT = 0.9;thrm.kT.max = 5;thrm.redshift = 0.009;freeze(absrb.nH)" \
  return_value=thrm.kT.val \
  verb=1 clob+






