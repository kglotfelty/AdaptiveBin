#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR


dragon_scales infile=$INDIR/smimg.fits rad=12 \
  out=$OUTDIR/ds_const_circle.map \
  bin=$OUTDIR/ds_const_circle.img \
  shape=circle verbose=0 clob+ 

dragon_scales infile=$INDIR/smimg.fits rad=$INDIR/min500cts.rad \
  out=$OUTDIR/ds_vary_circle.map \
  bin=$OUTDIR/ds_vary_circle.img \
  shape=circle verbose=0 clob+ 

dragon_scales infile=$INDIR/smimg.fits rad=12 \
  out=$OUTDIR/ds_const_box.map \
  bin=$OUTDIR/ds_const_box.img \
  shape=box verbose=0 clob+ 

dragon_scales infile=$INDIR/smimg.fits rad=12 \
  out=$OUTDIR/ds_const_diamond.map \
  bin=$OUTDIR/ds_const_diamond.img \
  shape=diamond verbose=0 clob+ 




