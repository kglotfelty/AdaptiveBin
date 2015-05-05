#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

hexgrid in=$INDIR/img.fits \
  out=$OUTDIR/hex_10.map binimg=$OUTDIR/hex_10.img \
  side=10 xref=0 yref=0 clob+ 

hexgrid in=$INDIR/img.fits \
  out=$OUTDIR/hex_10_offset.map binimg=$OUTDIR/hex_10_offset.img \
  side=10 xref=3 yref=5 clob+ 

