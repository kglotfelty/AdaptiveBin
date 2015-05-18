#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

grow_from_max infile=$INDIR/smimg.fits \
  out=$OUTDIR/gm_box.map bin=$OUTDIR/gm_box.img \
  shape=box rad=2.5 clob+ verbose=1
  

grow_from_max infile=$INDIR/smimg.fits \
  out=$OUTDIR/gm_circle.map bin=$OUTDIR/gm_circle.img \
  shape=circle rad=1.5 clob+ verbose=1


