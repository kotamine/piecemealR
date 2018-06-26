--- 
title: "Piecemeal R"
subtitle: "Tutorial for Data Exploration with R"
# author: "Kota Minegishi"
date: "Last updated: 2018-06-26"
# always_allow_html: yes
output: 
  bookdown::gitbook:
    split_by: section+number
    css: style.css
    config:
      toc: 
        toc: true
        toc_depth: 3
        collapse: subsection
        scroll_highlight: yes
        before: |
          <li><a href="./">Piecemeal R</a></li>
        after: |
          <li><a href="https://bookdown.org/yihui/bookdown" target="blank">Published with bookdown</a></li>
      edit: https://github.com/kotamine/piecemealR/edit/master/%s
      code_folding: show
      highlight: zenburn
      toolbar:
        position: fixed
      download: null
      search: yes
      fontsettings:
        family: serif 
        size: 2
      sharing:
        facebook: yes
        twitter: yes
        linkedin: yes
    includes:
      in_header: _includes/google_analytics.html
      after_body: _includes/disqus.html
# documentclass: book
bibliography: [articles.bib, book.bib]
biblio-style: apalike
link-citations: yes
github-repo: /kotamine/piecemealR
description: "This is a R tutorial. "
# setwd("/Users/kota/Dropbox/R_projects/piecemealR")
# library(bookdown)
# bookdown::render_book("index.Rmd", "bookdown::gitbook",  output_dir = "docs", new_session = TRUE, output_options = list(split_by ="section+number"))
---

# Welcome {#index}

Welcome to a tutorial website for data analysis and visualization with [R](https://www.r-project.org/). 

Two objectives of this site are: 

  - Introducing R's modern data analytics tools (Section \@ref(intro))
  - Providing topic-based tutorials (Section \@ref(piecemeal-top))  

Additional materials include: 

  - Essential concepts for R programming (Section \@ref(essentials))
  - List of additional resources (Section \@ref(resources))

## About {-} 

This site is created and maintained by __Kota Minegishi__, an assistant professor at the University of Minnesota. He is an agricultural economist and works in the Department of Animal Science.    

<!--
More content will be added when the author hosts a small workshop  _"Data Exploration with R"_  at his workplace.     


__Workshop__ 

- ~~random sampling, bootstrapping, and linear models \@ref(boot): July 3, 5-6pm (4:30 recap), Haecker 365~~

- ~~dplyr and ggplot2 exercise \@ref(dplyr): April 20, 5-6pm, Haecker 365.~~
-->

<!-- 
__New Contents__

* 2018-06-26: Section \@ref(boot) Action, Romance, and Chicks -->

<!-- * 2018-06-26: <span style="color:red">*Test upload. VERY Preliminary!*</span> 

-->









