
qr:
	quarto render

all:
	quarto render
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 --delete _book/ bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/cidados/

qp:
	quarto preview 

qs:
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 --delete _book/ bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/cidados/

