DEST := ../
ARCHIVEDIR = resume.$(shell date -r myres.pdf +%Y%m%d)
.PHONY: go build deploy copy cpmake link dolinks archive doarchive

go:build dolinks

build: 
	ant

deploy:copy link archive

copy:cpmake
	cp myres.pdf $(DEST)
	cp index.html $(DEST)
	cp myres.html $(DEST)
	cp index.html $(DEST)

cpmake:
	cp Makefile $(DEST)

link:
	$(MAKE) -C $(DEST) dolinks

dolinks:
	ln -sf myres.pdf My_Name_Resume.pdf
	ln -sf myres.html My_Name_Resume.html

archive:cpmake
	$(MAKE) -C $(DEST) doarchive

doarchive:
	mkdir -p $(ARCHIVEDIR)
	cp -a myres.pdf $(ARCHIVEDIR)
	cp -a myres.html $(ARCHIVEDIR)
	cp -a index.html $(ARCHIVEDIR)

