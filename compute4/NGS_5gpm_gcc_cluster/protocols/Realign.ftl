
#MOLGENIS walltime=35:59:00 mem=10 cores=4

module load GATK/1.0.5069
module list

inputs "${dedupbam}" 
inputs "${indexfile}" 
inputs "${dbsnprod}"
inputs "${pilot1KgVcf}"
inputs "${realignTargets}"
alloutputsexist "${realignedbam}"

java -Djava.io.tmpdir=${tempdir} -Xmx10g -jar \
$GATK_HOME/GenomeAnalysisTK.jar \
-l INFO \
-T IndelRealigner \
-U ALLOW_UNINDEXED_BAM \
-I ${dedupbam} \
--out ${realignedbam} \
-targetIntervals ${realignTargets} \
-R ${indexfile} \
-D ${dbsnprod} \
-B:indels,VCF ${pilot1KgVcf} \
-knownsOnly \
-LOD 0.4 \
-maxReads 2000000