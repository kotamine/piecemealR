#!/bin/sh

Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook",  output_dir = "docs", new_session = TRUE,  
	output_options = list(split_by ="section"))'