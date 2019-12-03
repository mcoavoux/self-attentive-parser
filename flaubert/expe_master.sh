source /home/getalp/coavouxm/anaconda3/bin/activate py36
hostname
whoami
python --version
conda --version

cd ..

SPMRL="/home/getalp/coavouxm/data/SPMRL_SHARED_2014_NO_ARABIC"
trainpath="${SPMRL}/FRENCH_SPMRL/gold/ptb/train/train.French.gold.ptb"
devpath="${SPMRL}/FRENCH_SPMRL/gold/ptb/dev/dev.French.gold.ptb"

constants="--train-path ${trainpath} --dev-path ${devpath} --evalb-dir EVALB_SPMRL  --predict-tags"

modeldir=flaubert/expe/models${1}
logdir=flaubert/expe/logs${1}

mkdir -p ${modeldir}
mkdir -p ${logdir}

modelname=${2}

shift
shift


echo python src/main.py train ${constants} --model-path-base ${modeldir}/${modelname} $@  >  ${logdir}/log_${modelname}.out
git rev-parse HEAD >>  ${logdir}/log_${modelname}.out
python src/main.py train ${constants} --model-path-base ${modeldir}/${modelname} $@  >>  ${logdir}/log_${modelname}.out  2>  ${logdir}/log_${modelname}.err


