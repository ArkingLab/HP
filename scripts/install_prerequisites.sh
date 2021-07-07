#!/usr/bin/env bash 
set -ex
#######################################################################

#Program that downloads and install software prerequisites and hs38DH.fa

########################################################################

. $HP_SDIR/init.sh
cd $HP_HDIR
mkdir -p prerequisites/ $HP_BDIR/ $HP_JDIR/
cd prerequisites/

wget -N -c https://netactuate.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2
if [ ! -s $HP_BDIR/bwa ] ; then
  tar -xjvf bwa-0.7.17.tar.bz2
  cd bwa-0.7.17
  make ; cp bwa $HP_BDIR/
  cd -
fi

#update to 1.12
wget -N -c https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
if [ ! -s $HP_BDIR/samtools ] ; then
  tar -xjvf samtools-1.11.tar.bz2
  cd samtools-1.11
  ./configure --prefix=$HP_HDIR/ ; make ;  make install
  cd -
fi

wget -N -c https://github.com/samtools/bcftools/releases/download/1.11/bcftools-1.11.tar.bz2
if [ ! -s $HP_BDIR/bcftools ] ; then
  tar -xjvf  bcftools-1.11.tar.bz2
  cd bcftools-1.11
  ./configure --prefix=$HP_HDIR/ ; make ; make install
  cd -
fi

wget -N -c https://github.com/samtools/htslib/releases/download/1.11/htslib-1.11.tar.bz2
if [ ! -s $HP_BDIR/tabix ] ; then
  tar -xjvf htslib-1.11.tar.bz2
  cd htslib-1.11
  ./configure --prefix=$HP_HDIR/ ; make ; make install
  cd -
fi

wget -N -c https://github.com/GregoryFaust/samblaster/releases/download/v.0.1.26/samblaster-v.0.1.26.tar.gz
if [ ! -s $HP_BDIR/samblaster ] ; then
  tar -xzvf samblaster-v.0.1.26.tar.gz
  cd samblaster-v.0.1.26
  make ; cp samblaster $HP_BDIR/
  cd -
fi

wget -N -c https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz
if [ ! -s $HP_BDIR/vcftools ] ; then
  tar -xzvf vcftools-0.1.16.tar.gz
  cd vcftools-0.1.16
  ./configure --prefix=$HP_HDIR/  ; make ; make install
  cd -
fi

wget -N -c https://github.com/nferraz/st/archive/v1.1.4.tar.gz #-O st-1.1.4.tar.gz
if [ ! -s $HP_BDIR/st ] ; then
  tar -xzvf v1.1.4.tar.gz # st-1.1.4.tar.gz
  cd st-1.1.4
  perl ./Makefile.PL INSTALL_BASE=$HP_HDIR/ ; make ; make install
  cd -
fi

#update to 2.30
wget -N -c https://github.com/arq5x/bedtools2/releases/download/v2.29.2/bedtools-2.29.2.tar.gz
if [ ! -s $HP_BDIR/bedtools ] ; then
  tar -xzvf bedtools-2.29.2.tar.gz
  cd bedtools2/
  make install prefix=$HP_HDIR/
  cd -
fi

wget -N -c https://github.com/OpenGene/fastp/archive/v0.20.1.tar.gz #-O fastp-0.20.1.tar.gz
if [ ! -s $HP_BDIR/fastp ] ; then
  tar -xzvf v0.20.1.tar.gz # fastp-0.20.1.tar.gz
  cd fastp-0.20.1/
  make ; cp fastp $HP_BDIR/
  cd -
fi

wget -N -c https://github.com/broadinstitute/gatk/releases/download/4.2.0.0/gatk-4.2.0.0.zip
if [ ! -s $HP_JDIR/gatk.jar ] ; then
  unzip -o gatk-4.2.0.0.zip
  cp gatk-4.2.0.0/gatk-package-4.2.0.0-local.jar $HP_JDIR/gatk.jar
  cp gatk $HP_BDIR/
fi

wget -N -c https://github.com/seppinho/haplogrep-cmd/releases/download/v2.2.9/haplogrep.zip
if [ ! -s $HP_JDIR/haplogrep.jar ] ; then
  unzip -o haplogrep.zip
  cp haplogrep.jar $HP_JDIR/
fi

wget -N -c https://github.com/genepi/haplocheck/releases/download/v1.3.3/haplocheck.zip
if [ ! -s $HP_JDIR/haplocheck.jar ] ; then
  unzip -o haplocheck.zip
  cp haplocheck.jar $HP_JDIR/
fi

wget -N -c https://github.com/seppinho/mutserve/releases/download/v2.0.0-rc12/mutserve.zip
if [ ! -s $HP_JDIR/mutserve.jar ] ; then
  unzip -o mutserve.zip
  cp mutserve.jar $HP_JDIR
fi

wget -N -c ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
if [ ! -s $HP_RDIR/hs38DH.fa ] ; then
  cp GRCh38_full_analysis_set_plus_decoy_hla.fa $HP_RDIR/hs38DH.fa
  $HP_BDIR/samtools faidx $HP_RDIR/hs38DH.fa
fi

