
ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Alfred Duncan <a.j.m.duncan@kent.ac.uk>"

USER root

# Julia LaTeX integration
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-binaries \
    texlive-luatex \
    pdf2svg && \
    rm -rf /var/lib/apt/lists/*

# Add Julia packages.
RUN julia -e "using Pkg; pkg\"add DataFrames TikzPictures LightGraphs MetaGraphs GraphPlot TikzGraphs LinearAlgebra Latexify JuMP Ipopt\"; pkg\"precompile\""
   
# move kernelspec out of home \ 
RUN fix-permissions $JULIA_PKGDIR $CONDA_DIR/share/jupyter
