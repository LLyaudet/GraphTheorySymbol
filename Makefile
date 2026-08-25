build:
	lualatex graph-theory-symbol.ins
	lualatex graph-theory-symbol.dtx
	test -e graph-theory-symbol.glo && makeindex -s gglo.ist -o graph-theory-symbol.gls graph-theory-symbol.glo
	makeindex -s gind.ist -o graph-theory-symbol.ind graph-theory-symbol.idx
	lualatex graph-theory-symbol.dtx
	mv graph-theory-symbol.pdf graph-theory-symbol-doc.pdf
	lualatex test.tex
clean:
	rm -f -- *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out *.toc
