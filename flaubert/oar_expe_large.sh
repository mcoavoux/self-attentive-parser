

# Settings with no pretrained language model (Kitaev and Klein, 2018)
usechars="--use-chars-lstm --d-char-emb 64"

# Settings pretrained language model (Kitaev, Cao and Klein, 2019)
#kitaevoptions="--learning-rate 0.00005 --num-layers 2 --batch-size 32 --eval-batch-size 32"
kitaevoptions="--num-layers 2 --eval-batch-size 8"


bert_id_xlm_base="../xlm_bert_fra_base_lower"
bert_id_xlm_large="../xlm_bert_fra_large_lower"

#flaubert_large_v0_id="../flaubert_large_cased_v0"

flaubert_large="flaubert-large-cased"


#bert_xlm_nolower_base=" --use-bert --bert-model ${bert_id_xlm_base} --no-bert-do-lower-case ${kitaevoptions}"
#bert_xlm_nolower_large="--use-bert --bert-model ${bert_id_xlm_large} --no-bert-do-lower-case ${kitaevoptions}"
bert_xlm_lower_base="   --use-bert --bert-model ${bert_id_xlm_base}                         ${kitaevoptions}"
bert_xlm_lower_large="  --use-bert --bert-model ${bert_id_xlm_large}                        ${kitaevoptions}"

flaubert_large_v0="  --use-bert --bert-model ${flaubert_large} --no-bert-do-lower-case ${kitaevoptions}"


# Camembert
bert_camembert="  --use-bert --bert-model camembert-base      --no-bert-do-lower-case       ${kitaevoptions}"

# multilingual bert
bert_id_mlb=bert-base-multilingual-cased
bert_mlb="        --use-bert --bert-model ${bert_id_mlb} --no-bert-do-lower-case ${kitaevoptions}"


# no bert
bert_nobert="${usechars}"
bert_nobert_fasttext="${usechars} --use-words --fasttext ../cc.fr.300.vec"


#folder=3dec_all_experiments
folder="26fev_bert_large"


batchsize=8
maxlen=100
lr=0.00001
#for lr in 0.0001 0.00005 0.00001 0.000005 0.000001 

#oarsub -l /core=8/gpu=1,walltime=16 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed_${lr}_${batchsize}     ${flaubert_large_v0} --learning-rate  ${lr} --max-len-train 80 --batch-size ${batchsize}"
oarsub -l /core=8/gpu=1,walltime=48 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed_${lr}_${batchsize}_${maxlen}     ${flaubert_large_v0} --learning-rate  ${lr} --max-len-train ${maxlen} --batch-size ${batchsize}"
oarsub -l /core=8/gpu=1,walltime=48 "bash expe_master.sh ${folder} model_flaubert_large_v1_seed_${lr}_${batchsize}_${maxlen}     ${flaubert_large_v0} --learning-rate  ${lr} --max-len-train ${maxlen} --batch-size ${batchsize}"
oarsub -l /core=8/gpu=1,walltime=48 "bash expe_master.sh ${folder} model_flaubert_large_v2_seed_${lr}_${batchsize}_${maxlen}     ${flaubert_large_v0} --learning-rate  ${lr} --max-len-train ${maxlen} --batch-size ${batchsize}"



#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed2     ${flaubert_large_v0}"
#oarsub -l /core=8/gpu=1,walltime=30 "bash expe_master.sh ${folder} model_flaubert_large_v0_seed3     ${flaubert_large_v0}"


