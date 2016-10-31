dtk-bibliography.pdf: dtk-bibliography.tex dtk-bibliography-utf8.bib
	arara dtk-bibliography.tex

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml