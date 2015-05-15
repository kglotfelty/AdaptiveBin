#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR



merge_too_small infile=$INDIR/ds_vary_circle.map  \
  imgfile=$INDIR/img.fits \
  outfile=$OUTDIR/m2s_20.map binimg=$OUTDIR/m2s_20.img \
  method=area minval=20 \
  mode=h clob+ verb=1

merge_too_small infile=$INDIR/ds_vary_circle.map  \
  imgfile=$INDIR/img.fits \
  outfile=$OUTDIR/m2s_100counts.map binimg=$OUTDIR/m2s_100counts.img \
  method=counts minval=100 \
  mode=h clob+ verb=1
