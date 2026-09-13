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
                    graph-theory-symbol-doc-A4.pdf\
                    graph-theory-symbol-doc-USLetter.pdf\
                    graph-theory-symbol-memo-A4.pdf\
                    graph-theory-symbol-memo-USLetter.pdf

build: graph-theory-symbol.sty\
       graph-theory-symbol-doc-A4.pdf\
       graph-theory-symbol-doc-USLetter.pdf\
       graph-theory-symbol-doc-Book.pdf\
       graph-theory-symbol-memo-A4.pdf\
       graph-theory-symbol-memo-USLetter.pdf\
       graph-theory-symbol-memo-Book.pdf\
       test-A4.pdf\
       test-USLetter.pdf\
       test-Book.pdf

graph-theory-symbol.sty: graph-theory-symbol.ins graph-theory-symbol.dtx
	lualatex graph-theory-symbol.ins

graph-theory-symbol-doc-A4.pdf: graph-theory-symbol.sty\
                                graph-theory-symbol.dtx\
                                $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-doc-A4\
    "\def\buildtarget{0} \input{graph-theory-symbol.dtx}"
	test -e graph-theory-symbol-doc-A4.glo\
    && makeindex -s gglo.ist -o graph-theory-symbol-doc-A4.gls\
      graph-theory-symbol-doc-A4.glo
	makeindex -s gind.ist -o graph-theory-symbol-doc-A4.ind\
      graph-theory-symbol-doc-A4.idx
	lualatex --jobname=graph-theory-symbol-doc-A4\
    "\def\buildtarget{0} \input{graph-theory-symbol.dtx}"

graph-theory-symbol-doc-USLetter.pdf: graph-theory-symbol.sty\
                                      graph-theory-symbol.dtx\
                                      $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-doc-USLetter\
    "\def\buildtarget{1} \input{graph-theory-symbol.dtx}"
	test -e graph-theory-symbol-doc-USLetter.glo\
    && makeindex -s gglo.ist -o graph-theory-symbol-doc-USLetter.gls\
      graph-theory-symbol-doc-USLetter.glo
	makeindex -s gind.ist -o graph-theory-symbol-doc-USLetter.ind\
      graph-theory-symbol-doc-USLetter.idx
	lualatex --jobname=graph-theory-symbol-doc-USLetter\
    "\def\buildtarget{1} \input{graph-theory-symbol.dtx}"

graph-theory-symbol-doc-Book.pdf: graph-theory-symbol.sty\
                                graph-theory-symbol.dtx\
                                $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-doc-Book\
    "\def\buildtarget{2} \input{graph-theory-symbol.dtx}"
	test -e graph-theory-symbol-doc-Book.glo\
    && makeindex -s gglo.ist -o graph-theory-symbol-doc-Book.gls\
      graph-theory-symbol-doc-Book.glo
	makeindex -s gind.ist -o graph-theory-symbol-doc-Book.ind\
      graph-theory-symbol-doc-Book.idx
	lualatex --jobname=graph-theory-symbol-doc-Book\
    "\def\buildtarget{2} \input{graph-theory-symbol.dtx}"

graph-theory-symbol-memo-A4.pdf: graph-theory-symbol.sty\
                                 graph-theory-symbol-memo.tex\
                                 $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-A4\
    "\def\buildtarget{0} \input{graph-theory-symbol-memo.tex}"

graph-theory-symbol-memo-USLetter.pdf: graph-theory-symbol.sty\
                                       graph-theory-symbol-memo.tex\
                                       $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-USLetter\
    "\def\buildtarget{1} \input{graph-theory-symbol-memo.tex}"

graph-theory-symbol-memo-Book.pdf: graph-theory-symbol.sty\
                                   graph-theory-symbol-memo.tex\
                                   $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-Book\
    "\def\buildtarget{2} \input{graph-theory-symbol-memo.tex}"

test-A4.pdf: graph-theory-symbol.sty test.tex
	lualatex --jobname=test-A4 "\def\buildtarget{0} \input{test.tex}"

test-USLetter.pdf: graph-theory-symbol.sty test.tex
	lualatex --jobname=test-USLetter "\def\buildtarget{1} \input{test.tex}"

test-Book.pdf: graph-theory-symbol.sty test.tex
	lualatex --jobname=test-Book "\def\buildtarget{2} \input{test.tex}"

archive: graph-theory-symbol.tar.gz

graph-theory-symbol.tar.gz: $(archivable-files)
	cp -r $(archivable-files) graph-theory-symbol/
	tar czf graph-theory-symbol.tar.gz graph-theory-symbol/

clean:
	rm -f -- *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out *.toc
