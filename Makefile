all:
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex

clean:
	rm -f *~ *.ps *.dvi *.log *.out
	rm -f *.blg *.bbl *.aux *.idx *.pag
