memo:
# All Rmd files (except those starting with “_”) are copied into “_main.Rmd” and compiled



# ------- Build the book  (see in _build.sh file) --------

library(bookdown)

bookdown::render_book("index.Rmd", "bookdown::gitbook",  output_dir = "docs", new_session = TRUE, output_options = list(split_by ="section+number"), preview=TRUE)


bookdown::render_book("index.Rmd", "bookdown::pdf_book",  output_dir = "docs", new_session = TRUE)

bookdown::render_book("index.Rmd", "bookdown::epub_book",  output_dir = "docs", new_session = TRUE, output_options = list(chapter_level = 3))



# ------- Preview the book ---------------

library(bookdown)
library(rmarkdown)

preview_chapter("index.Rmd")

preview_chapter("04-01-tidy-dplyr.Rmd")


bookdown::serve_book( in_session = FALSE, output_dir = "docs")


# ------- Preview HTML chapter ---------------

# use render() to compile a single Rmd document for a HTML page preview.
# e.g.

library(rmarkdown)
setwd("~/Dropbox/R_projects/piecemealR")

render("index.Rmd", "html_document")

render("00-About.Rmd", "html_document")

render("01-Introduction.Rmd", "html_document")

render("02-Essentials.Rmd", "html_document")

render("03-Good-to-Knows.Rmd", "html_document")

render("04-00-Piecemeal-Topic.Rmd", "html_document")

render("04-01-tidy-dplyr.Rmd", "html_document")

render("04-02-next.Rmd", "html_document")

render("05-Resources.Rmd", "html_document")










