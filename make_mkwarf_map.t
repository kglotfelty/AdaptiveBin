#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR


mkdir -p $OUTDIR/arfs/

make_mkwarf_map \
  infile=$INDIR/img.fits \
  mapfile=$INDIR/four+rot.map \
  outroot=$OUTDIR/arfs/out \
  asphist=$INDIR/ahist.fits \
  rmffile=$INDIR/rmf.fits \
  verbose=1 clob+
  
  

  





