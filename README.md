
This is a fork from Nikita Kitaev's [self-attentive parser](https://github.com/nikitakit/self-attentive-parser)
that was used to perform constituency parsing experiments described in [FlauBERT](https://github.com/mcoavoux/self-attentive-parser) [paper](https://arxiv.org/abs/1912.05372).

# Installation: Python / Conda set-up

    git clone https://github.com/mcoavoux/self-attentive-parser
    cd self-attentive-parser

    conda create --name FlaubertParse --file requirements-conda.txt
    conda activate FlaubertParse
    pip install -r requirements.txt



# Parse French sentences with pretrained models

Download and uncompress pretrained models:

    wget https://zenodo.org/record/3696502/files/french_parsing_models.tar.gz
    mkdir french_parsing_models
    tar xzf french_parsing_models.tar.gz -C french_parsing_models

The folder `french_parsing_models` will contain 3 pretrained models (trained respectively with flaubert-base, flaubert-large, camembert-base).

Parse with pretrained model:

    conda activate FlaubertParse

    # Parse with Flaubert Pretrained model (adapt batch size depending on available memory)
    python src/main.py parse --model-path-base french_parsing_models/model_flaubert_base_seed1_dev=88.96.pt --input-path to_parse.txt --output-path to_parse.parsed --eval-batch-size 10

    # Parse with Camembert Pretrained model
    python src/main.py parse --model-path-base french_parsing_models/model_camembert_seed2_dev=88.35.pt --input-path to_parse.txt --output-path to_parse.parsed --eval-batch-size 10

The input file should contain one sentence per line (already tokenized as in the French Treebank).
You can check if the results are correct by comparing the models' output to `to_parse_{camembert,flaubert}_expected_result.parsed`.


# Retrain and evaluate models


If you want to retrain with Fasttext embeddings, you should download them [here](https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.fr.300.vec.gz).

1. Install Evalb

        cd self-attentive-parser
        cd EVALB_SPMRL
        make
        cd ..

2. Train models


        cd flaubert

        # change absolute path to conda environment in flaubert/expe_master.sh (first line)
        # change absolute path to data folder in flaubert/expe_master.sh (`SPMRL` variable)
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


