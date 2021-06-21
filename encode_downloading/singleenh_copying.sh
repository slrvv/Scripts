DIR=/project/CRUP_scores/CRUP_scores/RESULTS
FILE=1_ENHANCER_PREDICTIONS/singleEnh.bedGraph
for RUN in Pair_ended Single_ended
do
  for CELL in Cell_lines Primary_cells Tissues
  do
    for SAMPLE in $(ls $DIR/$RUN/$CELL)
    do
      cp $DIR/$RUN/$CELL/$SAMPLE/$FILE /project/CRUP_scores/CRUP_scores/SingleEnhFiles/singleEnh_$SAMPLE.bedGraph
    done
  done
done
