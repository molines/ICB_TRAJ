# Makefile for CDFTOOLS_3.0

# ( make.macro is a link that points to the file macro.xxx where 
#   xxx is representative of your machine )
# !!----------------------------------------------------------------------
# !! CDFTOOLS_3.0 , MEOM 2011
# !! $Id$
# !! Copyright (c) 2010, J.-M. Molines
# !! Software governed by the CeCILL licence (Licence/CDFTOOLSCeCILL.txt)
# !!----------------------------------------------------------------------

include make.macro

BINDIR = bin

VPATH = $(BINDIR)

EXEC = icb_traj_read

.PHONY: all help clean cleanexe install man installman zclass_list.txt

all: $(EXEC)

icb_traj_read : icb_traj_read.f90
	$(F90) icb_traj_read.f90 -o $(BINDIR)/icb_traj_read $(FFLAGS)

help:
	@echo "#-------------------------------------------------"
	@echo "# List of make targets:"
	@echo "#  all          : build cdftools binary"
	@echo "#  man          : build manual"
	@echo "#  clean        : remove building object (.o, .mod...)"
	@echo "#  cleanexe     : remove binary executable"
	@echo "#  install      : install binary in INSTALL folder"
	@echo "#  installman   : install manual in INSTALL_MAN folder"
	@echo "#-------------------------------------------------"

## Statistical programs

## Utilities
clean:
	\rm -f *.mod *.o  *~ *.1 *.opod

cleanexe: clean
	( cd $(BINDIR) ; \rm -f $(EXEC) )

install:
	@mkdir -p $(INSTALL)
	cd ../bin ; \cp $(EXEC)  $(INSTALL)
