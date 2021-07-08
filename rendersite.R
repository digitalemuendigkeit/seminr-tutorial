


rmarkdown::render_site("website")


# Pick al slides and create PDFS
# Extract PDF Pages and PNGS
# Extract matching script
# Generat Website pages

pagedown::chrome_print("slides/basics/20_basics-data-prep.html",output="test.pdf")
