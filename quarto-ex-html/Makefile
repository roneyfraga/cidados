file=index

qrpdf:
	quarto render $(file).qmd --to pdf

qrall:
	quarto render $(file).qmd --to pdf
	quarto render $(file).qmd --to html
	quarto render $(file).qmd --to docx

qrhtml:
	quarto render $(file).qmd --to html

qrdocx:
	quarto render $(file).qmd --to docx 

qrrevealjs:
	quarto render $(file).qmd --to revealjs

qrrevealjs:
	quarto preview $(file).qmd --to revealjs

qppdf:
	quarto preview $(file).qmd --to pdf

qphtml:
	quarto preview $(file).qmd --to html

qs:
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 index.html index_files bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/projects/quarto-ex-html/

all:
	quarto render $(file).qmd --to html
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 index.html index_files bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/projects/quarto-ex-html/

