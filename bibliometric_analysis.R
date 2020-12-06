# Bibliometric analyses (brainhack marburg 2020, code by Mathias Scharinger, from various manuals)

# Bibliometric analysis in R with library bibliometrix
# Data from Web of Science (WoS) shoud be imported as bibtex files
# First, load library
library(bibliometrix)
# Further libraries needed
library(reshape2)
library(ggplot2)

# Then define working directory
setwd("~/Dropbox/Articles/Brainhack/Bibliometrics")

# Start with the first data set import (*predictions in speech and language*)
prediction=convert2df('predictions.bib',dbsource='wos',format = 'bibtex')
# Do a first bibliographic analysis and store results in "results"
results = biblioAnalysis(prediction, sep = ";")

# Display results as text
options(width=100)
S = summary(object = results, k = 10, pause = FALSE)

# Plot results
plot(x = results, k = 10, pause = FALSE)

# Plot top author's production over time
topAU = authorProdOverTime(prediction, k = 10, graph = TRUE)

# Create a historical co-citation network
options(width=130)
histResults = histNetwork(prediction, min.citations = 5, sep = ";")

# Plot the historical co-citation network
net = histPlot(histResults, n=25, size = 10, labelsize=5)

# Calculate thematic evaluation of a research field
nexus = thematicEvolution(prediction,field="ID", years=c(2000), n=50,minFreq=3)
nexus

# Create a country collaboration network
M = metaTagExtraction(prediction, Field = "AU_CO", sep = ";")
NetMatrix = biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.8)

# Create a co-citation network
NetMatrix = biblioNetwork(prediction, analysis = "co-citation", network = "references", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T,remove.multiple=FALSE, labelsize=0.7,edgesize = 5)

# Create keyword co-occurrences network
NetMatrix = biblioNetwork(prediction, analysis = "co-occurrences", network = "keywords", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)

# Create a conceptual structure map
CS = conceptualStructure(prediction,field="ID", method="MCA", minDegree=4, clust=4 ,k.max=8, stemming=FALSE, labelsize=10, documents=10)

# Extract highest number of Citations
CR = citations(prediction, field = "article", sep = ";")
CR$Cited[1:10]
CR$Year[1:10]
CR$Source[1:10]

# Dominance of authors
dominance(results)

# Keyword growth
topkw=KeywordGrowth(prediction, Tag = "ID", sep = ";", top = 10, cdf = TRUE)
# Plotting keyword growth
DF=melt(topkw, id='Year') # reshape original data structure
ggplot(DF,aes(Year,value, group=variable, color=variable))+geom_line()

# Spectroscopy of literature (overview of cited sources)
res = rpys(prediction, sep=";",graph = TRUE)
res$rpysTable # check early references
res$CR[1,1:2]

# Three field plots
threeFieldsPlot(prediction, fields=c("DE","AU","CR"),n=c(20,20,20))

#####-----------------------------------------------------------------
# Continue with second example (*auditory voice hallucinations*)
hallucination = convert2df('auditory_hallucinations.bib',dbsource='wos',format = 'bibtex')
# Do a first bibliographic analysis and store results in "results"
results = biblioAnalysis(hallucination, sep = ";")

# Display results as text
options(width=100)
S = summary(object = results, k = 10, pause = FALSE)

# Plot results
plot(x = results, k = 10, pause = FALSE)

# Create a historical co-citation network
options(width=130)
histResults = histNetwork(hallucination, min.citations = 5, sep = ";")

# Plot the historical co-citation network
net = histPlot(histResults, n=25, size = 10, labelsize=5)

# Calculate thematic evaluation of a research field
nexus = thematicEvolution(hallucination,field="ID", years=c(2000), n=50,minFreq=3)
nexus

# Create a country collaboration network
M = metaTagExtraction(hallucination, Field = "AU_CO", sep = ";")
NetMatrix = biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.8)

# Create a co-citation network
NetMatrix = biblioNetwork(hallucination, analysis = "co-citation", network = "references", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T,remove.multiple=FALSE, labelsize=0.7,edgesize = 5)

# Create keyword co-occurrences network
NetMatrix = biblioNetwork(hallucination, analysis = "co-occurrences", network = "keywords", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)

# Create a conceptual structure map
CS = conceptualStructure(hallucination,field="ID", method="MCA", minDegree=10, clust=4 ,k.max=8, stemming=FALSE, labelsize=10, documents=5)

# Extract highest number of Citations
CR = citations(hallucination, field = "article", sep = ";")
CR$Cited[1:10]
CR$Year[1:10]
CR$Source[1:10]

# Dominance of authors
dominance(results)

# Keyword growth
topkw=KeywordGrowth(hallucination, Tag = "ID", sep = ";", top = 10, cdf = TRUE)
# Plotting keyword growth
DF=melt(topkw, id='Year') # reshape original data structure
ggplot(DF,aes(Year,value, group=variable, color=variable))+geom_line()

# Spectroscopy of literature (overview of cited sources)
res = rpys(hallucination, sep=";",graph = TRUE)
res$rpysTable # check early references
res$CR[1,1:2]

# Three field plots
threeFieldsPlot(hallucination, fields=c("DE","AU","CR"),n=c(20,20,20))


# Source (journal) growth
topSO=sourceGrowth(hallucination, top = 5, cdf = TRUE)
DF=melt(topSO, id='Year')
ggplot(DF,aes(Year,value, group=variable, color=variable))+geom_line()

# Network statistics
NetMatrix = biblioNetwork(hallucination, analysis = "co-citation", network = "references", sep = ";")
netstat = networkStat(NetMatrix, stat = "all", type = "degree")
summary(netstat)

# Productivity analysis
prod_analysis = lotka(results)
# Evaluate results
# Goodness of fit
prod_analysis$R2

# Observed distribution
Observed=prod_analysis$AuthorProd[,3]

# Theoretical distribution with Beta = 2
Theoretical=10^(log10(L$C)-2*log10(prod_analysis$AuthorProd[,1]))
# Plot comparison
plot(prod_analysis$AuthorProd[,1],Theoretical,type="l",col="red",ylim=c(0, 1), xlab="Articles",ylab="Freq. of Authors",main="Scientific Productivity")
lines(prod_analysis$AuthorProd[,1],Observed,col="blue")
legend(x="topright",c("Theoretical (B=2)","Observed"),col=c("red","blue"),lty = c(1,1,1),cex=0.6,bty="n")




