FROM jupyter/datascience-notebook:latest

USER root
RUN apt-get update && \
  apt-get install -y vim gzip wget curl

RUN julia -e 'using Pkg; Pkg.add("Plots");' && \
  julia -e 'using Pkg; Pkg.add("Statistics");' && \
  julia -e 'using Pkg; Pkg.add("Gadfly");' && \
  julia -e 'using Pkg; Pkg.add("IJulia");' && \
  julia -e 'using Pkg; Pkg.add("DataFrames");' && \
  julia -e 'using Pkg; Pkg.add("PyPlot");' && \
  julia -e 'using Pkg; Pkg.add("ImageView");' && \
  julia -e 'using Pkg; Pkg.add("StatsFuns");' && \
  julia -e 'using Pkg; Pkg.add("Turing");' && \
  julia -e 'using Pkg; Pkg.add("Flux");' && \
  julia -e 'using Pkg; Pkg.add("ScikitLearn");' && \
  julia -e 'using Pkg; Pkg.add("PyCall");' && \
  julia -e 'using Pkg; Pkg.add("MLDatasets");'

