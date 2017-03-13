all:
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex

slides:
	pdflatex slides-meta-extract-pauses.tex
	pdflatex slides-meta-extract-pauses.tex
	pdflatex slides-meta-extract-no-pauses.tex
	pdflatex slides-meta-extract-no-pauses.tex

clean:
	rm -f *~ *.ps *.dvi *.log *.out *.nav *.snm *.toc *.vrb
	rm -f *.blg *.bbl *.aux *.idx *.pag
