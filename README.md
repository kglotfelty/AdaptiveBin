![Banner](doc/ds9.png)

# Adaptive Binning Routines

This repo contains several adaptive binning routines for use in 
[CIAO](http://cxc.cfa.harvard.edu/ciao).  These include

- `contour_map` : follows local contours
- `dragon_scales` : overlapping shapes
- `grow_from_max` : Voronoi tesselation map
- `hexgrid` : regular hexagonal grid
- `mkregmap` : stack of regions to a map
- `pathfinder` : steepest ascent
- `centroid_map` : iterative centroid map



Users may also be interested in the compiled tools

- [`dmnautilus`](https://github.com/kglotfelty/dmnautilus-) (upgraded from CIAO version)
- [`dmradar`](https://github.com/kglotfelty/dmradar) polar version of `dmnautilus`

These are C programs that need to be built into your CIAO installation.
(You do not have to build all of CIAO or even have the CIAO source code installed).

## Installation

Users must have CIAO installed and have already sourced the setup script.  
Then if you installed CIAO using `conda` just

```bash
git clone https://github.com/kglotfelty/AdaptiveBin
cd AdaptiveBin
python setup.py install 
```

or if you installed CIAO using `ciao-install` then 

```bash
git clone https://github.com/kglotfelty/AdaptiveBin
cd AdaptiveBin
python setup.py build -f -e "/usr/bin/env python" install -f --prefix=$ASCDS_CONTRIB
```

You will then need to re-index your ahelp to get access to the
help files

```bash
ahelp -r
```


## Banner

In the banner image above, from left to right we have
original data, `dmnautilus` (original), `contour_map`, `grow_from_max`, 
`pathfinder`, `dragon_scales`, `hexmap`, `mkregmap`, 
`centroid_map`, and `dmradar`


