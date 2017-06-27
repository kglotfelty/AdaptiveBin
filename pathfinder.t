#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR

pathfinder infile=$INDIR/smimg.fits \
  out=$OUTDIR/pf_diag.map \
  direction=diagonal minval=1.0 clob+ verbose=1

pathfinder infile=$INDIR/smimg.fits \
  out=$OUTDIR/pf_perp.map \
  direction=perpendicular minval=1.0 clob+ verbose=1
  


