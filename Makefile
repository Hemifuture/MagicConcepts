# Latex Makefile

all: pdf html
	@make clean-temp
.PHONY: all

# ------------------------------------------------------------------------------

build-tex-once:
	lualatex -shell-escape -interaction nonstopmode concepts.tex
.PHONY: build-tex-once


pdf: tex
	lualatex -shell-escape -interaction nonstopmode --jobname='An.Introduction.to.Magic.Hemifuture.2023' concepts.tex 1>lualatex.log && echo "build tex 1st!"      \
	&& lualatex -shell-escape -interaction nonstopmode --jobname='An.Introduction.to.Magic.Hemifuture.2023' concepts.tex 1>>lualatex.log  && echo "build tex 2nd!" \
	&& lualatex -shell-escape -interaction nonstopmode --jobname='An.Introduction.to.Magic.Hemifuture.2023' concepts.tex 1>>lualatex.log && echo "done!"
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
	rm -f *.pdf
.PHONY: clean-pdf

clean-tex:
	rm -rf *.{log,out,aux,toc,tex,tex~,fdb_latexmk,fls}
	rm -f texput.log
	rm -f lualatex.log
.PHONY: clean-tex

clean-temp: clean-tex
	rm -rf *.*~
.PHONY: clean-temp

clean-html:
	rm -f *.html
.PHONY: clean-html

clean-all: clean-tex clean-html clean-pdf
.PHONY: clean-all
