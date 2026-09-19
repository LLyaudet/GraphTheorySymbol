.PHONY: build archive clean

tex-directory-files := ./tex/memo-preamble.tex\
                       ./tex/memo-symbols-meta-logic.tex\
                       ./tex/memo-symbols-monochrome.tex\
                       ./tex/memo-symbols-standard.tex\
                       ./tex/memo-versatile-macros.tex

archivable-files := COPYING\
                    COPYING.LESSER\
                    DEPENDS.txt\
                    graph-theory-symbol.dtx\
                    graph-theory-symbol.ins\
                    graph-theory-symbol-doc-A4.pdf\
                    graph-theory-symbol-doc-USLetter.pdf\
                    graph-theory-symbol-memo.tex\
                    graph-theory-symbol-memo-A4.pdf\
                    graph-theory-symbol-memo-USLetter.pdf\
                    graph-theory-symbol-test.tex\
                    Makefile\
                    README.md\
                    tex/\
                    VERSION_*


build: graph-theory-symbol.sty\
       graph-theory-symbol-doc-A4.pdf\
       graph-theory-symbol-doc-Book.pdf\
       graph-theory-symbol-doc-USLetter.pdf\
       graph-theory-symbol-memo-A4.pdf\
       graph-theory-symbol-memo-Book.pdf\
       graph-theory-symbol-memo-USLetter.pdf\
       graph-theory-symbol-test-A4.pdf\
       graph-theory-symbol-test-Book.pdf\
       graph-theory-symbol-test-USLetter.pdf

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

graph-theory-symbol-memo-A4.pdf: graph-theory-symbol.sty\
                                 graph-theory-symbol-memo.tex\
                                 $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-A4\
    "\def\buildtarget{0} \input{graph-theory-symbol-memo.tex}"

graph-theory-symbol-memo-Book.pdf: graph-theory-symbol.sty\
                                   graph-theory-symbol-memo.tex\
                                   $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-Book\
    "\def\buildtarget{2} \input{graph-theory-symbol-memo.tex}"

graph-theory-symbol-memo-USLetter.pdf: graph-theory-symbol.sty\
                                       graph-theory-symbol-memo.tex\
                                       $(tex-directory-files)
	lualatex --jobname=graph-theory-symbol-memo-USLetter\
    "\def\buildtarget{1} \input{graph-theory-symbol-memo.tex}"

graph-theory-symbol-test-A4.pdf: graph-theory-symbol.sty\
                                 graph-theory-symbol-test.tex
	lualatex --jobname=graph-theory-symbol-test-A4\
    "\def\buildtarget{0} \input{graph-theory-symbol-test.tex}"

graph-theory-symbol-test-Book.pdf: graph-theory-symbol.sty\
                                   graph-theory-symbol-test.tex
	lualatex --jobname=graph-theory-symbol-test-Book\
    "\def\buildtarget{2} \input{graph-theory-symbol-test.tex}"

graph-theory-symbol-test-USLetter.pdf: graph-theory-symbol.sty\
                                       graph-theory-symbol-test.tex
	lualatex --jobname=graph-theory-symbol-test-USLetter\
    "\def\buildtarget{1} \input{graph-theory-symbol-test.tex}"

archive: build graph-theory-symbol.tar.gz

graph-theory-symbol.tar.gz: $(archivable-files)
	cp -r $(archivable-files) graph-theory-symbol/
	tar czf graph-theory-symbol.tar.gz graph-theory-symbol/

clean:
	rm -f -- *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out *.toc
