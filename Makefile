.PHONY: build archive clean

tex-directory-files := ./tex/switch-to-memo-geometry.tex\
                       ./tex/return-to-previous-geometry.tex\
                       ./tex/memo-symbols-standard.tex\
                       ./tex/memo-symbols-monochrome.tex\
                       ./tex/memo-symbols-meta-logic.tex\
                       ./tex/memo-preamble.tex\
                       ./tex/memo-versatile-macros.tex

archivable-files := README.md\
                    Makefile\
                    VERSION_*\
                    DEPENDS.txt\
                    COPYING\
                    COPYING.LESSER\
                    graph-theory-symbol.ins\
                    graph-theory-symbol.dtx\
                    graph-theory-symbol-memo.tex\
                    test.tex\
                    tex/\
                    graph-theory-symbol-doc.pdf\
                    graph-theory-symbol-memo.pdf

build: graph-theory-symbol.sty\
       graph-theory-symbol-doc.pdf\
       graph-theory-symbol-memo.pdf\
       test.pdf

graph-theory-symbol.sty: graph-theory-symbol.ins graph-theory-symbol.dtx
	lualatex graph-theory-symbol.ins

graph-theory-symbol-doc.pdf: graph-theory-symbol.sty\
                             graph-theory-symbol.dtx\
                             $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-doc graph-theory-symbol.dtx
	test -e graph-theory-symbol-doc.glo && makeindex -s gglo.ist\
    -o graph-theory-symbol-doc.gls graph-theory-symbol-doc.glo
	makeindex -s gind.ist -o graph-theory-symbol-doc.ind graph-theory-symbol-doc.idx
	lualatex --jobname=graph-theory-symbol-doc graph-theory-symbol.dtx

graph-theory-symbol-memo.pdf: graph-theory-symbol.sty\
                              graph-theory-symbol-memo.tex\
                              $(tex-directory-files)
	lualatex graph-theory-symbol-memo.tex

test.pdf: graph-theory-symbol.sty test.tex
	lualatex test.tex

archive: graph-theory-symbol.tar.gz

graph-theory-symbol.tar.gz: $(archivable-files)
	cp -r $(archivable-files) graph-theory-symbol/
	tar czf graph-theory-symbol.tar.gz graph-theory-symbol/

clean:
	rm -f -- *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out *.toc
