# latexmk configuration -- this template is XeLaTeX-only.
$pdf_mode = 5;                 # 5 = xelatex
$dvi_mode = $postscript_mode = 0;

# Only build what is actually here, so that deleting the example -- which is
# the first thing most people do -- does not make a bare `latexmk` fail.
@default_files = grep { -e } ('main.tex', 'example-cute.tex');

$clean_ext = 'bbl nav out snm synctex.gz xdv run.xml bcf';
