##Runs crup through all of the repository data

#Assume merged files (if we have replicates) and info.txt for all of the samples

DIRFILES=/project/CRUP_scores/CRUP_scores/ENCODE/Encode_data ###Directory where we can find all of the encode data
DIRCRUP=/home/lopez_s/CRUP_testrun/CRUP
DIRPROM=/home/lopez_s/CRUP_testrun/CRUP_Prom
TYPESAMPLE=$2 #Is it Cell_lines,Primary_cells or Tissues (write it exactly as the name of the folder)
TYPERUN=$1 #is it Pair_ended or Single_ended

RESULTS=/project/CRUP_scores/CRUP_scores/RESULTS/$TYPERUN/$TYPESAMPLE
NORM=0_NORMALIZED_DATA
PRED=1_ENHANCER_PREDICTIONS
PROM=1_PROMOTER_PREDICTIONS
if [ "$TYPERUN" = "Single_ended" ]
then
  RUN=single
else
  RUN=paired
fi


for SAMPLE in $(ls -F $DIRFILES/$TYPERUN/$TYPESAMPLE | grep / )
do
    ###Make the directories to store the results
    echo $SAMPLE
    mkdir $RESULTS/$SAMPLE
    mkdir $RESULTS/$SAMPLE$NORM
    mkdir $RESULTS/$SAMPLE$PRED
    mkdir $RESULTS/$SAMPLE$PROM
    echo "Made the folders to store the results"
    INFO=$DIRFILES/$TYPERUN/$TYPESAMPLE/${SAMPLE}info.txt
    OUT_INFO=$RESULTS/$SAMPLE$NORM
    P_INPUT=$RESULTS/$SAMPLE$NORM/info.data_matrix.rds
    P_OUTPUT=$RESULTS/$SAMPLE$PRED
    P_OUT2=$RESULTS/$SAMPLE$PROM
    #CRUP normalization
    Rscript $DIRCRUP/CRUP.R -N -i $INFO -g hg38 -s single -o $OUT_INFO

    #CRUP EP
    echo "Enhancer prediction"
    Rscript $DIRCRUP/CRUP.R -P -x 5 -m $P_INPUT -o $P_OUTPUT
    echo "Promoter prediction"
    echo $DIRCRUP
    echo $DIRPROM
    Rscript $DIRPROM/CRUP_Prom.R -P -x 5 -m $P_INPUT -o $P_OUT2

done

#Rscript /home/lopez_s/CRUP_testrun/CRUP/CRUP.R -P -x 5 -m /project/CRUP_scores/RESULTS/Pair_ended/Cell_lines/HCT116/0_NORMALIZED_DATA/info.data_matrix.rds -o /project/CRUP_scores/RESULTS/Pair_ended/Cell_lines/HCT116/1_RF_PREDICTIONS
