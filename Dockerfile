FROM library/julia

MAINTAINER Alex Fraczak

# Install GLPK
RUN apt-get update && \
    apt-get install --yes \
      glpk-utils \
      libglpk-dev \
      glpk-doc && \
    apt-get clean

# Install AWS CLI via pip
RUN apt-get install --yes \
    python-pip \
    python-dev \
    build-essential && \
    pip install --upgrade pip && \
    pip install awscli --upgrade --user

ENV PATH="~/.local/bin:${PATH}"

# Install julia dependencies
RUN julia -e "Pkg.add(\"GLPK\"); Pkg.build(\"GLPK\")" && \
    julia -e "Pkg.add(\"GLPKMathProgInterface\")" && \
    julia -e "Pkg.add(\"JuMP\")" && \
    julia -e "Pkg.add(\"DataFrames\")"

