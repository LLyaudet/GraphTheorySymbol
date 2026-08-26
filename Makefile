.PHONY: build archive clean

build: graph-theory-symbol-doc.pdf test.pdf

graph-theory-symbol-doc.pdf: graph-theory-symbol.ins graph-theory-symbol.dtx test.tex
	lualatex graph-theory-symbol.ins
	lualatex graph-theory-symbol.dtx
	test -e graph-theory-symbol.glo && makeindex -s gglo.ist -o graph-theory-symbol.gls graph-theory-symbol.glo
	makeindex -s gind.ist -o graph-theory-symbol.ind graph-theory-symbol.idx
	lualatex graph-theory-symbol.dtx
	mv graph-theory-symbol.pdf graph-theory-symbol-doc.pdf
	lualatex test.tex

test.pdf: graph-theory-symbol.ins graph-theory-symbol.dtx test.tex
	lualatex test.tex

archive: graph-theory-symbol.tar.gz

graph-theory-symbol.tar.gz: README.md Makefile VERSION_* DEPENDS.txt COPYING COPYING.LESSER graph-theory-symbol.ins graph-theory-symbol.dtx test.tex graph-theory-symbol-doc.pdf
	tar czf graph-theory-symbol.tar.gz README.md Makefile VERSION_* DEPENDS.txt COPYING COPYING.LESSER graph-theory-symbol.ins graph-theory-symbol.dtx test.tex graph-theory-symbol-doc.pdf

clean:
	rm -f -- *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out *.toc
