## Assemblies for Run 3 (Psan65) and Run 4 (Psan68) with high accuracy basecalling
## PYCOQC ##
dir_pycoqc=results/high_genome_assembly/qc
seq_sum_65=results/genome_assembly/minion_2022-03-30/sequencing_summary_FAS53852_d31b780d.txt
seq_sum_68=/fs/project/PAS0471/jelmer/assist/2021-12_linda/results/guppy/minion_2022-04-15/concat/sequencing_summary.txt
sbatch scripts/5-pycoqc.sh "$seq_sum_65" "$dir_pycoqc"/Run3_pycoqc.html
sbatch scripts/5-pycoqc.sh "$seq_sum_68" "$dir_pycoqc"/Run4_pycoqc.html
## FILTLONG ##
#comment out approriate script lines for ~45X and ~60X coverage based on genome size of 70Mb
sbatch scripts/5.5-filtlong.sh  \
    results/genome_assembly/minion_2022-03-30_HighAccuracy/P65_concat.fastq.gz \
    results/high_genome_assembly/filtlong/Psan65
sbatch scripts/5.5-filtlong.sh  \
    results/genome_assembly/minion_2022-04-15/P68_concat.fastq.gz \
    results/high_genome_assembly/filtlong/Psan68
## FASTQC + MULTIQC ##
dir_qc=results/high_genome_assembly/qc
in_65_45_fastq=results/high_genome_assembly/filtlong/Psan65/P65_45X.fastq.gz
in_65_60_fastq=results/high_genome_assembly/filtlong/Psan65/P65_60X.fastq.gz
in_68_45_fastq=results/high_genome_assembly/filtlong/Psan68/P68_45X.fastq.gz
in_68_60_fastq=results/high_genome_assembly/filtlong/Psan68/P68_60X.fastq.gz
sbatch scripts/3-fastqc.sh "$in_65_45_fastq" "$dir_qc"
sbatch scripts/3-fastqc.sh "$in_65_60_fastq" "$dir_qc"
sbatch scripts/3-fastqc.sh "$in_68_45_fastq" "$dir_qc"
sbatch scripts/3-fastqc.sh "$in_68_60_fastq" "$dir_qc"
fastq=results/high_genome_assembly/qc
sbatch scripts/4-multiqc.sh "$fastq" multiqc "$dir_qc"
## CANU ##
sbatch scripts/6-canu.sh Psan_65_45X results/high_genome_assembly/Canu/Psan_65_45X \
    results/high_genome_assembly/filtlong/Psan65/P65_45X.fastq.gz
sbatch scripts/6-canu.sh Psan_65_60X results/high_genome_assembly/Canu/Psan_65_60X \
    results/high_genome_assembly/filtlong/Psan65/P65_60X.fastq.gz
sbatch scripts/6-canu.sh Psan_68_45X results/high_genome_assembly/Canu/Psan_68_45X \
    results/high_genome_assembly/filtlong/Psan68/P68_45X.fastq.gz
sbatch scripts/6-canu.sh Psan_68_60X results/high_genome_assembly/Canu/Psan_68_60X \
    results/high_genome_assembly/filtlong/Psan68/P68_60X.fastq.gz
## NEXTDENOVO ##
sbatch scripts/7-nextdenovo.sh Psan_65_45X
sbatch scripts/7-nextdenovo.sh Psan_65_60X
sbatch scripts/7-nextdenovo.sh Psan_68_45X
sbatch scripts/7-nextdenovo.sh Psan_68_60X
## SMARTDENOVO ##
sbatch scripts/8-smartdenovo.sh \
    results/high_genome_assembly/filtlong/Psan65/P65_45X.fastq.gz \
    results/high_genome_assembly/SmartDenovo/Psan_65_45X/Psan_65_45X
sbatch scripts/8-smartdenovo.sh \
    results/high_genome_assembly/filtlong/Psan65/P65_60X.fastq.gz \
    results/high_genome_assembly/SmartDenovo/Psan_65_60X/Psan_65_60X
sbatch scripts/8-smartdenovo.sh \
    results/high_genome_assembly/filtlong/Psan68/P68_45X.fastq.gz \
    results/high_genome_assembly/SmartDenovo/Psan_68_45X/Psan_68_45X
sbatch scripts/8-smartdenovo.sh \
    results/high_genome_assembly/filtlong/Psan68/P68_60X.fastq.gz \
    results/high_genome_assembly/SmartDenovo/Psan_68_60X/Psan_68_60X
## NANOPOLISH ##
P65_45X_reads=results/high_genome_assembly/filtlong/Psan65/P65_45X.fastq.gz
P65_60X_reads=results/high_genome_assembly/filtlong/Psan65/P65_60X.fastq.gz
P68_45X_reads=results/high_genome_assembly/filtlong/Psan68/P68_45X.fastq.gz
P68_60X_reads=results/high_genome_assembly/filtlong/Psan68/P68_60X.fastq.gz
Canu_P65_45X_genome=results/high_genome_assembly/Canu/Psan_65_45X/Psan_65_45X.contigs.fasta
Canu_P65_60X_genome=results/high_genome_assembly/Canu/Psan_65_60X/Psan_65_60X.contigs.fasta
Canu_P68_45X_genome=results/high_genome_assembly/Canu/Psan_68_45X/Psan_68_45X.contigs.fasta
Canu_P68_60X_genome=results/high_genome_assembly/Canu/Psan_68_60X/Psan_68_60X.contigs.fasta
NextDenovo_P65_45X_genome=results/high_genome_assembly/NextDenovo/Psan_65_45X/03.ctg_graph/nd.asm.fasta
NextDenovo_P65_60X_genome=results/high_genome_assembly/NextDenovo/Psan_65_60X/03.ctg_graph/nd.asm.fasta
NextDenovo_P68_45X_genome=results/high_genome_assembly/NextDenovo/Psan_68_45X/03.ctg_graph/nd.asm.fasta
NextDenovo_P68_60X_genome=results/high_genome_assembly/NextDenovo/Psan_68_60X/03.ctg_graph/nd.asm.fasta
SmartDenovo_P65_45X_genome=results/high_genome_assembly/SmartDenovo/Psan_65_45X/Psan_65_45X.dmo.cns
SmartDenovo_P65_60X_genome=results/high_genome_assembly/SmartDenovo/Psan_65_60X/Psan_65_60X.dmo.cns
SmartDenovo_P68_45X_genome=results/high_genome_assembly/SmartDenovo/Psan_68_45X/Psan_68_45X.dmo.cns
SmartDenovo_P68_60X_genome=results/high_genome_assembly/SmartDenovo/Psan_68_60X/Psan_68_60X.dmo.cns
dir_nanopolish=results/high_genome_assembly/nanopolish
sbatch scripts/9-nanopolish.sh "$Canu_P65_45X_genome" "$P65_45X_reads" "$dir_nanopolish"/Canu_P65_45X
sbatch scripts/9-nanopolish.sh "$Canu_P65_60X_genome" "$P65_60X_reads" "$dir_nanopolish"/Canu_P65_60X
sbatch scripts/9-nanopolish.sh "$Canu_P68_45X_genome" "$P68_45X_reads" "$dir_nanopolish"/Canu_P68_45X
sbatch scripts/9-nanopolish.sh "$Canu_P68_60X_genome" "$P68_60X_reads" "$dir_nanopolish"/Canu_P68_60X
sbatch scripts/9-nanopolish.sh "$NextDenovo_P65_45X_genome" "$P65_45X_reads" "$dir_nanopolish"/NextDenovo_P65_45X
sbatch scripts/9-nanopolish.sh "$NextDenovo_P65_60X_genome" "$P65_60X_reads" "$dir_nanopolish"/NextDenovo_P65_60X
sbatch scripts/9-nanopolish.sh "$NextDenovo_P68_45X_genome" "$P68_45X_reads" "$dir_nanopolish"/NextDenovo_P68_45X
sbatch scripts/9-nanopolish.sh "$NextDenovo_P68_60X_genome" "$P68_60X_reads" "$dir_nanopolish"/NextDenovo_P68_60X
sbatch scripts/9-nanopolish.sh "$SmartDenovo_P65_45X_genome" "$P65_45X_reads" "$dir_nanopolish"/SmartDenovo_P65_45X
sbatch scripts/9-nanopolish.sh "$SmartDenovo_P65_60X_genome" "$P65_60X_reads" "$dir_nanopolish"/SmartDenovo_P65_60X
sbatch scripts/9-nanopolish.sh "$SmartDenovo_P68_45X_genome" "$P68_45X_reads" "$dir_nanopolish"/SmartDenovo_P68_45X
sbatch scripts/9-nanopolish.sh "$SmartDenovo_P68_60X_genome" "$P68_60X_reads" "$dir_nanopolish"/SmartDenovo_P68_60X
## QUICKMERGE ##
# -l 50 KB -ml 10000
#P65_45X
assembly1=results/high_genome_assembly/nanopolish/Canu_P65_45X/Psan_65_45X.contigs.fa
assembly2=results/high_genome_assembly/nanopolish/NextDenovo_P65_45X/nd.asm.fa
assembly_out=results/high_genome_assembly/Quickmerge/P65_45X_assembly1
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P65_45X_assembly1
assembly1=results/high_genome_assembly/nanopolish/SmartDenovo_P65_45X/Psan_65_45X.dmo.cns.fa
assembly2=results/high_genome_assembly/Quickmerge/merged_P65_45X_assembly1.fasta
assembly_out=results/high_genome_assembly/Quickmerge/P65_45X_assembly_final
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P65_45X_final
#P65_60X
assembly1=results/high_genome_assembly/nanopolish/Canu_P65_60X/Psan_65_60X.contigs.fa
assembly2=results/high_genome_assembly/nanopolish/NextDenovo_P65_60X/nd.asm.fa
assembly_out=results/high_genome_assembly/Quickmerge/P65_60X_assembly1
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P65_60X_assembly1
assembly1=results/high_genome_assembly/nanopolish/SmartDenovo_P65_60X/Psan_65_60X.dmo.cns.fa
assembly2=results/high_genome_assembly/Quickmerge/merged_P65_60X_assembly1.fasta
assembly_out=results/high_genome_assembly/Quickmerge/P65_60X_assembly_final
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P65_60X_final
#P68_45X
assembly1=results/high_genome_assembly/nanopolish/Canu_P68_45X/Psan_68_45X.contigs.fa
assembly2=results/high_genome_assembly/nanopolish/NextDenovo_P68_45X/nd.asm.fa
assembly_out=results/high_genome_assembly/Quickmerge/P68_45X_assembly1
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P68_45X_assembly1
assembly1=results/high_genome_assembly/nanopolish/SmartDenovo_P68_45X/Psan_68_45X.dmo.cns.fa
assembly2=results/high_genome_assembly/Quickmerge/merged_P68_45X_assembly1.fasta
assembly_out=results/high_genome_assembly/Quickmerge/P68_45X_assembly_final
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P68_45X_final
#P68_60X
assembly1=results/high_genome_assembly/nanopolish/Canu_P68_60X/Psan_68_60X.contigs.fa
assembly2=results/high_genome_assembly/nanopolish/NextDenovo_P68_60X/nd.asm.fa
assembly_out=results/high_genome_assembly/Quickmerge/P68_60X_assembly1
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P68_60X_assembly1
assembly1=results/high_genome_assembly/nanopolish/SmartDenovo_P68_60X/Psan_68_60X.dmo.cns.fa
assembly2=results/high_genome_assembly/Quickmerge/merged_P68_60X_assembly1.fasta
assembly_out=results/high_genome_assembly/Quickmerge/P68_60X_assembly_final
sbatch scripts/10-quickmerge.sh "$assembly1" "$assembly2" "$assembly_out" P68_60X_final
## NANOPOLISH ##
P65_45X_reads=results/high_genome_assembly/filtlong/Psan65/P65_45X.fastq.gz
P65_60X_reads=results/high_genome_assembly/filtlong/Psan65/P65_60X.fastq.gz
P68_45X_reads=results/high_genome_assembly/filtlong/Psan68/P68_45X.fastq.gz
P68_60X_reads=results/high_genome_assembly/filtlong/Psan68/P68_60X.fastq.gz
P65_45X_genome=results/high_genome_assembly/Quickmerge/merged_P65_45X_final.fasta
P65_60X_genome=results/high_genome_assembly/Quickmerge/merged_P65_60X_final.fasta
P68_45X_genome=results/high_genome_assembly/Quickmerge/merged_P68_45X_final.fasta
P68_60X_genome=results/high_genome_assembly/Quickmerge/merged_P68_60X_final.fasta
dir_nanopolish=results/high_genome_assembly/nanopolish
sbatch scripts/9-nanopolish.sh "$P65_45X_genome" "$P65_45X_reads" "$dir_nanopolish"/Quickmerge/P65_45X
sbatch scripts/9-nanopolish.sh "$P65_60X_genome" "$P65_60X_reads" "$dir_nanopolish"/Quickmerge/P65_60X
sbatch scripts/9-nanopolish.sh "$P68_45X_genome" "$P68_45X_reads" "$dir_nanopolish"/Quickmerge/P68_45X
sbatch scripts/9-nanopolish.sh "$P68_60X_genome" "$P68_60X_reads" "$dir_nanopolish"/Quickmerge/P68_60X
## BBMAP ##
module load python
source activate /users/PAS0471/jelmer/miniconda3/envs/bbmap-env
stats.sh results/high_genome_assembly/Canu/Psan_65_45X/Psan_65_45X.contigs.fasta > results/high_genome_assembly/bbmap/Canu_P65_45X
stats.sh results/high_genome_assembly/Canu/Psan_65_60X/Psan_65_60X.contigs.fasta > results/high_genome_assembly/bbmap/Canu_P65_60X
stats.sh results/high_genome_assembly/Canu/Psan_68_45X/Psan_68_45X.contigs.fasta > results/high_genome_assembly/bbmap/Canu_P68_45X
stats.sh results/high_genome_assembly/Canu/Psan_68_60X/Psan_68_60X.contigs.fasta > results/high_genome_assembly/bbmap/Canu_P68_60X
stats.sh results/high_genome_assembly/NextDenovo/Psan_65_45X/03.ctg_graph/nd.asm.fasta > results/high_genome_assembly/bbmap/NextDenovo_P65_45X
stats.sh results/high_genome_assembly/NextDenovo/Psan_65_60X/03.ctg_graph/nd.asm.fasta > results/high_genome_assembly/bbmap/NextDenovo_P65_60X
stats.sh results/high_genome_assembly/NextDenovo/Psan_68_45X/03.ctg_graph/nd.asm.fasta > results/high_genome_assembly/bbmap/NextDenovo_P68_45X
stats.sh results/high_genome_assembly/NextDenovo/Psan_68_60X/03.ctg_graph/nd.asm.fasta > results/high_genome_assembly/bbmap/NextDenovo_P68_60X
stats.sh results/high_genome_assembly/SmartDenovo/Psan_65_45X/Psan_65_45X.dmo.cns > results/high_genome_assembly/bbmap/SmartDenovo_P65_45X
stats.sh results/high_genome_assembly/SmartDenovo/Psan_65_60X/Psan_65_60X.dmo.cns > results/high_genome_assembly/bbmap/SmartDenovo_P65_60X
stats.sh results/high_genome_assembly/SmartDenovo/Psan_68_45X/Psan_68_45X.dmo.cns > results/high_genome_assembly/bbmap/SmartDenovo_P68_45X
stats.sh results/high_genome_assembly/SmartDenovo/Psan_68_60X/Psan_68_60X.dmo.cns > results/high_genome_assembly/bbmap/SmartDenovo_P68_60X
stats.sh results/high_genome_assembly/nanopolish/Canu_P65_45X/Psan_65_45X.contigs.fa > results/high_genome_assembly/bbmap/Nano_Canu_P65_45X
stats.sh results/high_genome_assembly/nanopolish/Canu_P65_60X/Psan_65_60X.contigs.fa > results/high_genome_assembly/bbmap/Nano_Canu_P65_60X
stats.sh results/high_genome_assembly/nanopolish/Canu_P68_45X/Psan_68_45X.contigs.fa > results/high_genome_assembly/bbmap/Nano_Canu_P68_45X
stats.sh results/high_genome_assembly/nanopolish/Canu_P68_60X/Psan_68_60X.contigs.fa > results/high_genome_assembly/bbmap/Nano_Canu_P68_60X
stats.sh results/high_genome_assembly/nanopolish/NextDenovo_P65_45X/nd.asm.fa > results/high_genome_assembly/bbmap/Nano_NextDenovo_P65_45X
stats.sh results/high_genome_assembly/nanopolish/NextDenovo_P65_60X/nd.asm.fa > results/high_genome_assembly/bbmap/Nano_NextDenovo_P65_60X
stats.sh results/high_genome_assembly/nanopolish/NextDenovo_P68_45X/nd.asm.fa > results/high_genome_assembly/bbmap/Nano_NextDenovo_P68_45X
stats.sh results/high_genome_assembly/nanopolish/NextDenovo_P68_60X/nd.asm.fa > results/high_genome_assembly/bbmap/Nano_NextDenovo_P68_60X
stats.sh results/high_genome_assembly/nanopolish/SmartDenovo_P65_45X/Psan_65_45X.dmo.cns.fa > results/high_genome_assembly/bbmap/Nano_SmartDenovo_P65_45X
stats.sh results/high_genome_assembly/nanopolish/SmartDenovo_P65_60X/Psan_65_60X.dmo.cns.fa > results/high_genome_assembly/bbmap/Nano_SmartDenovo_P65_60X
stats.sh results/high_genome_assembly/nanopolish/SmartDenovo_P68_45X/Psan_68_45X.dmo.cns.fa > results/high_genome_assembly/bbmap/Nano_SmartDenovo_P68_45X
stats.sh results/high_genome_assembly/nanopolish/SmartDenovo_P68_60X/Psan_68_60X.dmo.cns.fa > results/high_genome_assembly/bbmap/Nano_SmartDenovo_P68_60X
stats.sh results/high_genome_assembly/Quickmerge/merged_P65_45X_final.fasta > results/high_genome_assembly/bbmap/Quickmerge_P65_45X
stats.sh results/high_genome_assembly/Quickmerge/merged_P65_60X_final.fasta > results/high_genome_assembly/bbmap/Quickmerge_P65_60X
stats.sh results/high_genome_assembly/Quickmerge/merged_P68_45X_final.fasta > results/high_genome_assembly/bbmap/Quickmerge_P68_45X
stats.sh results/high_genome_assembly/Quickmerge/merged_P68_60X_final.fasta > results/high_genome_assembly/bbmap/Quickmerge_P68_60X
stats.sh results/high_genome_assembly/nanopolish/Quickmerge/P65_45X/merged_P65_45X_final.fa > results/high_genome_assembly/bbmap/Nano_Merge_P65_45X
stats.sh results/high_genome_assembly/nanopolish/Quickmerge/P65_60X/merged_P65_60X_final.fa > results/high_genome_assembly/bbmap/Nano_Merge_P65_60X
stats.sh results/high_genome_assembly/nanopolish/Quickmerge/P68_45X/merged_P68_45X_final.fa > results/high_genome_assembly/bbmap/Nano_Merge_P68_45X
stats.sh results/high_genome_assembly/nanopolish/Quickmerge/P68_60X/merged_P68_60X_final.fa > results/high_genome_assembly/bbmap/Nano_Merge_P68_60X
## BUSCO ##
# Submit when in BUSCO directory
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_65_45X/Psan_65_45X.contigs.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_65_45X/Psan_65_45X.contigs.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_65_60X/Psan_65_60X.contigs.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_65_60X/Psan_65_60X.contigs.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_65_45X/03.ctg_graph/nd.asm.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_65_45X/03.ctg_graph/nd.asm.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_65_60X/03.ctg_graph/nd.asm.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_65_60X/03.ctg_graph/nd.asm.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_65_45X/Psan_65_45X.dmo.cns "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_65_45X/Psan_65_45X.dmo.cns "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_65_60X/Psan_65_60X.dmo.cns "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_65_60X/Psan_65_60X.dmo.cns "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_68_45X/Psan_68_45X.contigs.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_68_45X/Psan_68_45X.contigs.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_68_60X/Psan_68_60X.contigs.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/Canu/Psan_68_60X/Psan_68_60X.contigs.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_68_45X/03.ctg_graph/nd.asm.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_68_45X/03.ctg_graph/nd.asm.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_68_60X/03.ctg_graph/nd.asm.fasta "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/NextDenovo/Psan_68_60X/03.ctg_graph/nd.asm.fasta "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_68_45X/Psan_68_45X.dmo.cns "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_68_45X/Psan_68_45X.dmo.cns "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_68_60X/Psan_68_60X.dmo.cns "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/SmartDenovo/Psan_68_60X/Psan_68_60X.dmo.cns "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P65_45X/merged_P65_45X_final.fa "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P65_45X/merged_P65_45X_final.fa "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P65_60X/merged_P65_60X_final.fa "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P65_60X/merged_P65_60X_final.fa "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P68_45X/merged_P68_45X_final.fa "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P68_45X/merged_P68_45X_final.fa "$out_dir" eukaryota_odb10
out_dir=stramenopiles
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P68_60X/merged_P68_60X_final.fa "$out_dir" stramenopiles_odb10
out_dir=eukaryota
sbatch /fs/project/PAS0471/linda/scripts/12-busco.sh /fs/project/PAS0471/linda/results/high_genome_assembly/nanopolish/Quickmerge/P68_60X/merged_P68_60X_final.fa "$out_dir" eukaryota_odb10
