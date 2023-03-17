# Latex Makefile

all: pdf html
	@make clean-temp
.PHONY: all

# ------------------------------------------------------------------------------

build-tex-once:
	xelatex -shell-escape -interaction nonstopmode concepts.tex
.PHONY: build-tex-once


pdf: tex
	xelatex -shell-escape -interaction nonstopmode concepts.tex 1>xelatex.log && echo "build tex 1st!"      \
	&& xelatex -shell-escape -interaction nonstopmode concepts.tex 1>>xelatex.log  && echo "build tex 2nd!" \
	&& xelatex -shell-escape -interaction nonstopmode concepts.tex 1>>xelatex.log && echo "done!"
	@make clean-temp
.PHONY: pdf


tex:
	emacs -Q --batch --find-file "concepts.org" -l "org-settings.el" -f "org-latex-export-to-latex" \
		&& echo "export tex done!"
.PHONY: tex

# ------------------------------------------------------------------------------

html: clean-html
	emacs -Q --batch --find-file "concepts.org" -l "org-settings.el" -f "org-html-export-to-html" \
		&& echo "build html done!"
.PHONY: html

# ------------------------------------------------------------------------------

clean-pdf:
	rm -f concepts.pdf
.PHONY: clean-pdf

clean-tex:
	rm -rf concepts.{log,out,aux,toc,tex,tex~,fdb_latexmk,fls}
	rm -f texput.log
	rm -f xelatex.log
.PHONY: clean-tex

clean-temp: clean-tex
	rm -rf *.*~
.PHONY: clean-temp

clean-html:
	rm -f concepts.html
.PHONY: clean-html

clean-all: clean-tex clean-html clean-pdf
.PHONY: clean-all
