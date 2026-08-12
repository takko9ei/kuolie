# latexmk configuration -- this template is XeLaTeX-only.
$pdf_mode = 5;                 # 5 = xelatex
$dvi_mode = $postscript_mode = 0;

@default_files = ('main.tex', 'example-cute.tex');

$clean_ext = 'bbl nav out snm synctex.gz xdv run.xml bcf';
