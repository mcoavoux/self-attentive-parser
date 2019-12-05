
Code to reproduce constituency parsing experiments from [FlauBERT](https://github.com/mcoavoux/self-attentive-parser) paper.

# Set up

1. Set up conda environment

        conda create --name FlaubertParse --file requirements-conda.txt
        conda activate FlaubertParse
        pip install -r requirements.txt

2. Get models

* Flaubert (see also instructions [here](https://github.com/getalp/Flaubert), download the `transformers` compatible version of Flaubert-BASE):

        wget https://zenodo.org/record/3562902/files/xlm_bert_fra_base_lower.tar
        tar xf xlm_bert_fra_base_lower.tar

* Camembert should be available through `from transformers import CamembertModel, CamembertTokenizer`, for now this can be achieved with a local clone/install of [transformers](https://github.com/huggingface/transformers)
* Fasttext embeddings (download [here](https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.fr.300.vec.gz))


3. Set up parser

        git clone https://github.com/mcoavoux/self-attentive-parser
        cd self-attentive-parser
        cd EVALB_SPMRL
        make
        cd ..


# Train models


    cd flaubert

    # change absolute path to conda environment in flaubert/expe_master.sh (first line)
    # change absolute path to data folder in flaubert/expe_master.sh (`SPMRL` variable)

    # change path to `xlm_bert_fra_base_lower` in flaubert/oar_expe.sh (`bert_id_xlm_base` variable)
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

# Pretrained models

TBD
