GHC = ghc

GHCFLAGS += -Wall
#GHCFLAGS += -Werror
GHCFLAGS += -isrc:src
GHCFLAGS += -O -rtsopts
GHCFLAGS += -odir obj -hidir obj

GHCFLAGS += \
	-hide-all-packages \
	-package base \
	-package containers \
	-package mtl \
	-package parsec

ifneq ($(wildcard .cabal-sandbox/*-packages.conf.d),)
GHCFLAGS += \
	-no-user-package-db \
	-package-db $(wildcard .cabal-sandbox/*-packages.conf.d)
endif

TARGETS = arith

.PHONY : all
all : $(TARGETS)

.PHONY : clean
clean:
	rm -rf obj $(TARGETS)

arith: src/*.hs
	$(GHC) $(GHCFLAGS) --make src/Main.hs -o arith
