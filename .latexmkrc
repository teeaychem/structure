$out_dir = '/Users/sparkes/Documents/TexTemp';
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape -synctex=1 -file-line-error %O %S' ;
$pdflatex .= ' && cp %D %B.pdf';
$pdflatex .= ' && cp %D %Z%B.synctex.gz .';
$pdf_mode = 1;
$preview_mode = 0;
# $postscript_mode = 0
# $dvi_mode = 0;

# $pdf_previewer = 'open -a skim';

$aux_dir = '/Users/sparkes/Documents/TexTemp';

# /Applications/Emacs.app/Contents/MacOS/bin/emacsclient