--- 
title: "Piecemeal R"
subtitle: "Tutorial for Data Exploration with R"
author: "Kota Minegishi"
date: "Last updated: 2018-06-02"
# always_allow_html: yes
output: 
  bookdown::gitbook:
    css: style.css
    config:
      toc: 
        collapse: section
        scroll_highlight: yes
        before: |
          <li><a href="./">Piecemeal R</a></li>
        after: |
          <li><a href="https://bookdown.org/yihui/bookdown" target="blank">Published with bookdown</a></li>
      edit: https://github.com/kotamine/piecemealR/edit/master/%s
      code_folding: show
      highlight: tango
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
---

# Welcome {#index}

Welcome to a tutorial website for data analysis and visualization with [R](https://www.r-project.org/). This site provides a quick overview and topic-based tutorials in a piecemeal fashion. 

The site is organized based on two questions: 

* How best to quickly introduce R to new audiences and showcase its data analytics tools? 

* How best to provide tutorials for topic-based data applications with R? 


To answer the first question, Section \@ref(intro) *Introduction* demonstrates a set of modern data analysis tools in R. Sections  \@ref(essentials) describes essential concepts of R. For the second question, Section \@ref(piecemeal-top) provides topic-based tutorials. Additional resources are listed in Section \@ref(resources).   

More content will be added when the author hosts a small workshop  _"Data Exploration with R"_  at his workplace.     


## About {-} 

__Kota Minegishi__ is an assistant professor of Dairy Analytics at the University of Minnesota. He is an agricultural economist by training and works in the Department of Animal Science.    

<!--
__Workshop__ 

- ~~random sampling, bootstrapping, and linear models \@ref(boot): July 3, 5-6pm (4:30 recap), Haecker 365~~

- ~~dplyr and ggplot2 exercise \@ref(dplyr): April 20, 5-6pm, Haecker 365.~~
-->

<!-- 
__New Contents__

* 2018-06-02: Section \@ref(boot) Action, Romance, and Chicks -->

<!-- * 2018-06-02: <span style="color:red">*Test upload. VERY Preliminary!*</span> --?









