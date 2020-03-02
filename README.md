
This is a fork from Nikita Kitaev's [self-attentive parser](https://github.com/nikitakit/self-attentive-parser)
that was used to perform constituency parsing experiments described in [FlauBERT](https://github.com/mcoavoux/self-attentive-parser) [paper](https://arxiv.org/abs/1912.05372).

# Installation: Python / Conda set-up

    git clone https://github.com/mcoavoux/self-attentive-parser
    cd self-attentive-parser

    conda create --name FlaubertParse --file requirements-conda.txt
    conda activate FlaubertParse
    pip install -r requirements.txt


2. Get models

* Flaubert (see also instructions [here](https://github.com/getalp/Flaubert), download the `transformers` compatible version of Flaubert-BASE):

        wget https://zenodo.org/record/3562902/files/xlm_bert_fra_base_lower.tar
        tar xf xlm_bert_fra_base_lower.tar

* Camembert should be available through `from transformers import CamembertModel, CamembertTokenizer`, for now this can be achieved with a local clone/install of [transformers](https://github.com/huggingface/transformers)
* Fasttext embeddings (download [here](https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.fr.300.vec.gz))

# Parse French sentences with pretrained models

Download and uncompress pretrained models:

    wget https://zenodo.org/record/3655703/files/french_parsing_models.tar.gz
    tar xzf french_parsing_models.tar.gz

Parse with pretrained model:

    conda activate FlaubertParse

    # Parse with Flaubert Pretrained model (adapt batch size depending on available memory)
    python src/main.py parse --model-path-base french_models/model_xlm_base_seed3_dev\=88.90.pt --input-path to_parse.txt --output-path to_parse.parsed --eval-batch-size 10

    # Parse with Camembert Pretrained model
    python src/main.py parse --model-path-base french_models/model_camembert_seed1_dev\=88.51.pt --input-path to_parse.txt --output-path to_parse.parsed --eval-batch-size 10


# Retrain and evaluate a model



3. Install Evalb

        cd self-attentive-parser
        cd EVALB_SPMRL
        make
        cd ..

4. Train models


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


