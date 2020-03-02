

# Settings with no pretrained language model (Kitaev and Klein, 2018)
usechars="--use-chars-lstm --d-char-emb 64"

# Settings pretrained language model (Kitaev, Cao and Klein, 2019)
kitaevoptions="--learning-rate 0.00005 --num-layers 2 --batch-size 32 --eval-batch-size 32"

largeoptions="--num-layers 2 --learning-rate 0.00001  --max-len-train  100 --batch-size 8 --eval-batch-size 16"

flaubert_base="   --use-bert --bert-model flaubert-base-cased           --no-bert-do-lower-case     ${kitaevoptions}"
flaubert_large="  --use-bert --bert-model flaubert-large-cased          --no-bert-do-lower-case     ${largeoptions}"
camembert_base="  --use-bert --bert-model camembert-base                --no-bert-do-lower-case     ${kitaevoptions}"
mbert="           --use-bert --bert-model bert-base-multilingual-cased  --no-bert-do-lower-case     ${kitaevoptions}"

# no bert
bert_nobert="${usechars}"
bert_nobert_fasttext="${usechars} --use-words --fasttext ../cc.fr.300.vec"


folder=march_02

# 3 random seeds per experiment
oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed1 ${bert_nobert_fasttext}"
oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed2 ${bert_nobert_fasttext}"
oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed3 ${bert_nobert_fasttext}"

oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed1 ${bert_nobert}"
oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed2 ${bert_nobert}"
oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed3 ${bert_nobert}"

oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed1    ${mbert}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed2    ${mbert}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed3    ${mbert}"

oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_base_seed1     ${flaubert_base}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_base_seed2     ${flaubert_base}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_base_seed3     ${flaubert_base}"

oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed1    ${camembert_base}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed2    ${camembert_base}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed3    ${camembert_base}"

oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_seed1     ${flaubert_large}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_seed2     ${flaubert_large}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_seed3     ${flaubert_large}"

