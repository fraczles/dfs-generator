FROM library/julia

MAINTAINER Alex Fraczak

RUN apt-get update && \
    apt-get install --yes \
      glpk-utils \
      libglpk-dev \
      glpk-doc && \
    apt-get clean

RUN julia -e "Pkg.add(\"GLPK\")"
RUN julia -e "Pkg.build(\"GLPK\")"
RUN julia -e "Pkg.add(\"GLPKMathProgInterface\")"
RUN julia -e "Pkg.add(\"JuMP\")"
RUN julia -e "Pkg.add(\"DataFrames\")"
