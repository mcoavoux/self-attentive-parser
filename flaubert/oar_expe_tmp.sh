

# Settings with no pretrained language model (Kitaev and Klein, 2018)
usechars="--use-chars-lstm --d-char-emb 64"

# Settings pretrained language model (Kitaev, Cao and Klein, 2019)
kitaevoptions="--learning-rate 0.00005 --num-layers 2 --batch-size 32 --eval-batch-size 32"


bert_id_xlm_base="../xlm_bert_fra_base_lower"
bert_id_xlm_large="../xlm_bert_fra_large_lower"

flaubert_large_v0_id="../flaubert_large_cased_v0"

#bert_xlm_nolower_base=" --use-bert --bert-model ${bert_id_xlm_base} --no-bert-do-lower-case ${kitaevoptions}"
#bert_xlm_nolower_large="--use-bert --bert-model ${bert_id_xlm_large} --no-bert-do-lower-case ${kitaevoptions}"
bert_xlm_lower_base="   --use-bert --bert-model ${bert_id_xlm_base}                         ${kitaevoptions}"
bert_xlm_lower_large="  --use-bert --bert-model ${bert_id_xlm_large}                        ${kitaevoptions}"

flaubert_large_v0="  --use-bert --bert-model ${flaubert_large_v0_id} --no-bert-do-lower-case ${kitaevoptions}"


# Camembert
bert_camembert="  --use-bert --bert-model camembert-base      --no-bert-do-lower-case       ${kitaevoptions}"

# multilingual bert
bert_id_mlb=bert-base-multilingual-cased
bert_mlb="        --use-bert --bert-model ${bert_id_mlb} --no-bert-do-lower-case ${kitaevoptions}"


# no bert
bert_nobert="${usechars}"
bert_nobert_fasttext="${usechars} --use-words --fasttext ../cc.fr.300.vec"


#folder=3dec_all_experiments
folder="22jan_bertlarge"



# 3 random seeds per experiment
#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed1 ${bert_nobert_fasttext}"
#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed2 ${bert_nobert_fasttext}"
#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_fasttext_seed3 ${bert_nobert_fasttext}"

#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed1 ${bert_nobert}"
#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed2 ${bert_nobert}"
#oarsub -l /core=8/gpu=1,walltime=20 "bash expe_master.sh ${folder} model_nobert_seed3 ${bert_nobert}"

#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed1    ${bert_mlb}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed2    ${bert_mlb}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_mbert_cased_seed3    ${bert_mlb}"

#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_xlm_base_seed1     ${bert_xlm_lower_base}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_xlm_base_seed2     ${bert_xlm_lower_base}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_xlm_base_seed3     ${bert_xlm_lower_base}"

#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed1    ${bert_camembert}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed2    ${bert_camembert}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_camembert_seed3    ${bert_camembert}"


oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed1     ${flaubert_large_v0}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed2     ${flaubert_large_v0}"
oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed3     ${flaubert_large_v0}"

#host='lig-gpu4.imag.fr


