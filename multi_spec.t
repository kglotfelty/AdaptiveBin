#!/bin/sh


OUTDIR=/pool1/kjg/abin
INDIR=data

mkdir -p $OUTDIR


multi_spec \
  infile=$INDIR/four+rot.map \
  evtfile=$INDIR/acisf09399_repro_evt2.fits \
  outroot=$OUTDIR/multi_spec_single_arf \
  srcmodel="xswabs.absrb*xsapec.thrm" \
  init="group_counts(5);set_method('levmar');absrb.nH = 0.0494;thrm.kT = 0.9;thrm.kT.max = 5;thrm.redshift = 0.009;freeze(absrb.nH) " \
  arffile=$INDIR/arf.fits \
  rmffile=$INDIR/rmf.fits \
  mode=h clob+ verb=2


multi_spec \
  infile=$INDIR/four+rot.map \
  evtfile=$INDIR/acisf09399_repro_evt2.fits \
  outroot=$OUTDIR/multi_spec_many_arf \
  srcmodel="xswabs.absrb*xsapec.thrm" \
  init="group_counts(5);set_method('levmar');absrb.nH = 0.0494;thrm.kT = 0.9;thrm.kT.max = 5;thrm.redshift = 0.009;freeze(absrb.nH) " \
  arffile=$INDIR/arfs/out \
  rmffile=$INDIR/rmf.fits \
  mode=h clob+ verb=2
  





