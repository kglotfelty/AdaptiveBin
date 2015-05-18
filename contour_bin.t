#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data/

mkdir -p $OUTDIR


# contour_bin
contour_bin in=$INDIR/psf_smimg_thresh.fits out=$OUTDIR/cb_circle.map \
  binimg=$OUTDIR/cb_circle.img dist=300 shape=circle levels=20 scale=log max=100 \
  verb=1 clob+

contour_bin in=$INDIR/psf_smimg_thresh.fits out=$OUTDIR/cb_box.map \
  binimg=$OUTDIR/cb_box.img dist=1000 shape=box levels=20 scale=linear max=100 \
  verb=2 clob+






