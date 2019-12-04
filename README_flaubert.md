
Code to reproduce experiments from FlauBERT paper.

# Set up

1. Conda environment

        conda create --name FlaubertParse --file requirements-conda.txt
        conda activate FlaubertParse
        pip install -r requirements.txt

2. Get models

* Flaubert (see [here](https://github.com/getalp/Flaubert))
* Camembert (todo)
* Fasttext embeddings (download [here](https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.fr.300.vec.gz))


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
    # in case oar scheduler is not available, just run commands inside the string passed in arguments of oarsub in oar_expe.sh


# Parse with models


    SPMRL=<path to SPMRL_SHARED_2014_NO_ARABIC>
    testpath="${SPMRL}/FRENCH_SPMRL/gold/ptb/test/test.French.gold.ptb"
    devpath="${SPMRL}/FRENCH_SPMRL/gold/ptb/dev/dev.French.gold.ptb"

    model=<path to trained model>

    python src/main.py test --test-path ${testpath} --evalb-dir EVALB_SPMRL --model-path-base ${model} > log_eval_test
    python src/main.py test --test-path ${devpath}  --evalb-dir EVALB_SPMRL --model-path-base ${model} > log_eval_dev


    # To parse from ensemble of several models (i.e. fine-tuned CamemBERT + fine-tuned FlauBERT)
    models="<path to fine-tuned camembert> <path to fine-tuned flaubert>"
    python src/main.py ensemble --test-path ${testpath} --evalb-dir EVALB_SPMRL --model-path-base ${models} --eval-batch-size 50 > log_eval_test
    python src/main.py ensemble --test-path ${devpath}  --evalb-dir EVALB_SPMRL --model-path-base ${models} --eval-batch-size 50 > log_eval_dev


