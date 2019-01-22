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

This repro was forked from my
[Temperature Map](https://github.com/kglotfelty/TemperatureMap) repro.

Users may also be interested in the compiled tools

- [`dmnautilus`](https://github.com/kglotfelty/dmnautilus-) (upgraded from CIAO version)
- [`dmradar`](https://github.com/kglotfelty/dmradar) polar version of `dmnautilus`

## Installation

Users must have CIAO installed and have already sourced the setup script.  
Then

```bash
git clone https://github.com/kglotfelty/AdaptiveBin
cd AdaptiveBin
python setup.py install 
```

If you do not have write access to your CIAO installtion, then 
you need to modify the `setup.cfg`.
