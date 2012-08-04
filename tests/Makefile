SHELL := /bin/bash

all:
	bash UnitTests.sh

speedTest:
	. common.sh ; runSpeedAnalysis

clean: 
	rm -f sanitizer main prog
	find . -name "*~" -delete
