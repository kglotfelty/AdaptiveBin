#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR


merge_too_small infile=$INDIR/ds_vary_circle.map  \
  imgfile=$INDIR/img.fits \
  outfile=$OUTDIR/m2s_20.map binimg=$OUTDIR/m2s_20.img \
  minarea=20 mode=h clob+ verb=1
