filename=nlafa

NO_COLOR=\x1b[0m
OK_COLOR=\x1b[32;01m
ERROR_COLOR=\x1b[31;01m
WARN_COLOR=\x1b[33;01m

OK_STRING=$(OK_COLOR)[OK]$(NO_COLOR)
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)
WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

define colorecho
      @tput setaf 6
      @echo "-->" $1
      @tput sgr0
endef

define pdfdone
      @tput bold
	  @tput setaf 2
      @echo $1
      @tput sgr0
endef

define psdone
      @tput bold
	  @tput setaf 3
      @echo $1
      @tput sgr0
endef

define starting
      @tput bold
	  @tput setaf 3
      @echo $1
      @tput sgr0
endef

.PHONY : pdf

pdf:
	@pdflatex -shell-escape ${filename}.tex
	$(call colorecho,"pdflatex")

all:
	@latexmk -pdf -shell-escape ${filename}.tex
	$(call colorecho,"pdflatex")

	$(call colorecho,"bibtex")
	@bibtex ${filename}
	
#   $(call colorecho,"makeglossaries")
#	@makeglossaries ${filename}

	$(call colorecho,"pdflatex")
	@latexmk -pdf -shell-escape ${filename}
	
 	#$(call colorecho,"makeindex")
 	#@makeindex ${filename}
	#makeindex ${filename}.nlo -s nomencl.ist -o ${filename}.nls

	$(call colorecho,"pdflatex")
	@latexmk -pdf -shell-escape ${filename}

nom:
	#@pdflatex -shell-escape ${filename}.tex
	#$(call colorecho,"pdflatex")

	pdflatex -shell-escape ${filename}.tex
	makeindex ${filename}.nlo -s nomencl.ist -o ${filename}.nls
	pdflatex -shell-escape ${filename}.tex

	##$(call colorecho,"makeindex")
 	#makeindex ${filename}
	#@pdflatex -shell-escape ${filename}.tex
	#$(call colorecho,"pdflatex")

medit:
	mate *.tex

ledit:
	@tput setaf 6
	@echo "apa"
	@tput sgr0
	@echo "hej"
	$(call colorecho,"Linking with")

readpdf:
	open ${filename}.pdf &

clean:
	rm -f *.ps *.pdf *.log *.aux *.out *.dvi *.bbl *.blg *.aux *.lot *.lof *.toc *.xdy *.gls *.glo *.glg *.acn *.idx *.ist *.fdb_latexmk *.fls *.pyg
bib:
	bibtex ${filename} 2>&1

glossaries:
	makeglossaries ${filename} 2>&1
