#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data/

mkdir -p $OUTDIR


# contour_bin
contour_bin in=$INDIR/psf_smimg.fits out=$OUTDIR/cb_circle.map \
  binimg=$OUTDIR/cb_circle.img dist=100 shape=circle frac=0.4 max=100 clob+

contour_bin in=$INDIR/psf_smimg.fits out=$OUTDIR/cb_box.map \
  binimg=$OUTDIR/cb_box.img dist=100 shape=box frac=0.4 max=100 clob+






