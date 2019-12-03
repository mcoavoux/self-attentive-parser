
Code to reproduce experiments from Flaubert paper (LINK)


# Install requirements

1. Conda environment

    conda create --name FlaubertParse --file requirements-conda.txt
    conda activate FlaubertParse
    pip install -r requirements.txt

2. Get models

* Flaubert (todo)
* Camembert (todo)
* Fasttext embeddings


3. Set up parser

    git clone https://github.com/mcoavoux/self-attentive-parser
    cd self-attentive-parser
    cd EVALB_SPMRL
    make
    cd ..


# Train models


    cd flaubert
    # change path to conda environment in flaubert/expe_master.sh
    # change absolute path to date in flaubert/expe_master.sh

    bash oar_expe.sh
    # in case oar scheduler is not available, just run commands inside the string passed in arguments of oarsub



# Parse with models


    
