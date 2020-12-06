# bibliometrix
R-Code for bibliometric analyses

For this project, two exemplary Web-of-Science searches have been conducted (search day: Dec. 06th, 2020).
The first search is on predictions in speech and language. Here, the search term involves Title (TI) and Authors' Keywords (AK):
Predictions: TI=((predicti*  AND  language)  OR  (predicti* AND speech)  OR  (preactivat* AND language)  OR  (preactivat* AND speech) )  AND  AK=(predicti*  OR  expectation*)


The second search is on auditory hallucinations with a particular emphasis on "voice". Here, the search term was in Topics (TS): Auditory hallucinations:  TS=(auditory  AND  hallucination*  AND  voice*)  


The repository includes export files from Web of Science with full bibliographic content.
The file for the first search is named: predictions.SUFFIX (where SUFFIX is .txt for a tab-delimited text-file for import in VOSviewer and .bib for further analysis in R).

Links needed:
https://apps.webofknowledge.com/  Web of Science

https://www.vosviewer.com/  VOS-Viewer

https://www.r-project.org/  R-Framework

https://rstudio.com/  R-Studio
