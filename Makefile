komplett: dtk-bibliography.tex dtk-bibliography-ascii.bib
	arara dtk-bibliography.tex

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml
