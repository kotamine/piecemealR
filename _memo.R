# memo:
# All Rmd files (except those starting with “_”) are copied into “_main.Rmd” and compiled



# ------- Build the book  (see in _build.sh file) --------

library(bookdown)

bookdown::render_book("index.Rmd", "bookdown::gitbook",  output_dir = "docs", new_session = TRUE, output_options = list(split_by ="section+number"))


# Somehow it doesn't get a right URL ...

bookdown::render_book("index.Rmd", "bookdown::pdf_book",  output_dir = "docs", new_session = TRUE)

bookdown::render_book("index.Rmd", "bookdown::epub_book",  output_dir = "docs", new_session = TRUE, output_options = list(chapter_level = 3))



# ------- Preview the book ---------------

library(bookdown)
library(rmarkdown)

preview_chapter("index.Rmd")

preview_chapter("04-01-tidy-dplyr.Rmd")
preview_chapter("04-02-boot.Rmd")


bookdown::serve_book( in_session = FALSE, output_dir = "docs")


# ------- Preview HTML chapter ---------------

# use render() to compile a single Rmd document for a HTML page preview.
# e.g.

library(rmarkdown)
setwd("~/Dropbox/R_projects/piecemealR")

render("/docs/index.Rmd", "html_document")

# render("/docs/00-About.Rmd", "html_document")

render("/docs/01-Introduction.Rmd", "html_document")

render("02-Essentials.Rmd", "html_document")

render("03-Good-to-Knows.Rmd", "html_document")

render("04-00-Piecemeal-Topic.Rmd", "html_document")

render("04-01-tidy-dplyr.Rmd", "html_document")

render("04-02-boot.Rmd", "html_document", clean = FALSE) #, intermediates_dir = "_bookdown_files/")


render("04-99-next.Rmd", "html_document")

render("05-Resources.Rmd", "html_document")










