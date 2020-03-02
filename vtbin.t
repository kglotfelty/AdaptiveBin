#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

vtbin infile=$INDIR/smimg.fits \
  out=$OUTDIR/vtbin_box.map bin=$OUTDIR/vtbin_box.img \
  shape=box rad=2.5 clob+ verbose=1
  

vtbin infile=$INDIR/smimg.fits \
  out=$OUTDIR/vtbin_circle.map bin=$OUTDIR/vtbin_circle.img \
  shape=circle rad=1.5 clob+ verbose=1


