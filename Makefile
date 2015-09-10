ROOT = /data/lenin2/Scripts/MyStuff/ciao46/ciao-4.6/contrib
DEV  = /data/da/Docs/scripts/dev

CP_F = /bin/cp -fv

BIN = contour_bin dragon_scales grow_from_max hexgrid image_tempmap merge_too_small multi_spec mkregmap make_mkwarf_map centroid_map
PAR = contour_bin.par dragon_scales.par grow_from_max.par hexgrid.par image_tempmap.par merge_too_small.par multi_spec.par mkregmap.par make_mkwarf_map.par centroid_map.par

all: 
	@$(CP_F) $(BIN) $(ROOT)/bin/
	@$(CP_F) $(PAR) $(ROOT)/param/

dev:
	@$(CP_F) $(BIN) $(DEV)/bin/
	@$(CP_F) $(PAR) $(DEV)/param/

