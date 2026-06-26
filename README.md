# Proposal

## Development of FoodNanoDetect: An Oxford Nanopore-Based Shotgun Metagenomic Pipeline for Rapid Foodborne Pathogen Detection and Surveillance

### Background

Foodborne pathogens remain a major public health concern worldwide and continue to pose significant challenges to food production, processing, and distribution systems. Rapid identification of microbial contaminants is essential for ensuring food safety, monitoring shelf life, tracing contamination sources, and responding to outbreak events. Conventional culture-based methods remain the regulatory gold standard but are labor-intensive, require several days to complete, and fail to detect many viable but non-culturable microorganisms.

Next-generation sequencing technologies have greatly improved microbial characterization in food systems. Amplicon sequencing (16S rRNA and ITS) provides valuable information regarding microbial community composition but lacks sufficient resolution for strain-level pathogen identification and functional characterization. Whole-genome sequencing offers high-resolution analysis but requires successful isolation of pure bacterial cultures. Illumina-based shotgun metagenomics enables culture-independent pathogen detection but typically requires centralized sequencing facilities, longer turnaround times, and complex laboratory workflows.

Oxford Nanopore Technologies (ONT) has emerged as an attractive alternative by providing portable, real-time, long-read sequencing capable of directly sequencing complex microbial communities. Long-read sequencing facilitates improved genome assembly, enhanced taxonomic resolution, and rapid identification of antimicrobial resistance (AMR) and virulence-associated genes. These characteristics make ONT particularly well suited for routine food safety surveillance.

Although several bioinformatics platforms, including the IDseq (currently CZ ID) framework, have demonstrated effective metagenomic pathogen detection, most existing workflows were originally developed for Illumina short-read sequencing and are not optimized for Oxford Nanopore data or food safety applications. Furthermore, few publicly available workflows integrate taxonomic classification, genome assembly, antimicrobial resistance analysis, virulence profiling, and automated reporting into a single reproducible pipeline.

---

## Objective

The overall objective of this project is to develop **FoodNanoDetect**, a reproducible Oxford Nanopore shotgun metagenomic analysis pipeline for rapid detection and characterization of foodborne pathogens from complex food and environmental samples.

Specific objectives include:

1. Establish an Oxford Nanopore sequencing workflow for shotgun metagenomic analysis of food and environmental samples.

2. Develop a modular bioinformatics pipeline optimized for Nanopore long-read sequencing.

3. Integrate automated taxonomic classification, genome assembly, antimicrobial resistance detection, and virulence profiling.

4. Generate standardized analytical reports suitable for food safety surveillance and outbreak investigations.

---

## Proposed Workflow

The proposed workflow consists of two major components:

### Laboratory Workflow

* DNA extraction
* DNA quality assessment
* Library preparation using the Oxford Nanopore Ligation Sequencing Kit V14
* Optional native barcoding for multiplexed sequencing
* Oxford Nanopore MinION sequencing

Sequencing generates raw POD5 files that serve as input for downstream computational analysis.

---

### Bioinformatics Workflow

FoodNanoDetect will be implemented as a modular **Nextflow** workflow to ensure reproducibility, scalability, and portability across local workstations, high-performance computing clusters, and cloud environments.

The pipeline consists of the following computational modules:

**Module 1 – Basecalling**

Raw nanopore signal data (POD5) will be converted into nucleotide sequences using **Dorado**, Oxford Nanopore's official high-accuracy basecaller. When barcoded libraries are used, demultiplexing will also be performed during this step.

**Input:** POD5

**Output:** FASTQ

---

**Module 2 – Read Quality Control**

Sequencing reads will undergo quality filtering using NanoFilt to remove low-quality and short reads prior to downstream analysis.

Quality metrics will be summarized using NanoPlot.

**Output:** High-quality FASTQ files

---

**Module 3 – Host DNA Removal**

Host-derived sequences originating from food matrices (e.g., chicken, beef, pork, seafood, or plant tissues) will be removed by mapping reads against the corresponding reference genome using Minimap2.

Removing host DNA reduces computational requirements while improving microbial detection sensitivity.
| Sample       | Host Genome                |
| ------------ | -------------------------- |
| Chicken meat | *Gallus gallus*            |
| Beef         | *Bos taurus*               |
| Pork         | *Sus scrofa*               |
| Seafood      | Species-specific reference |
| Vegetables   | Plant reference genome     |


**Output:** Host-depleted microbial reads

---

**Module 4 – Taxonomic Classification**

Microbial reads will be taxonomically classified using Kraken2 against a comprehensive microbial reference database.

Bracken will subsequently estimate species abundance by correcting classification biases inherent to k-mer-based classification.

Outputs include:

* Species identification
* Relative abundance
* Read counts
* Taxonomic composition

---

**Module 5 – Genome Assembly**

Microbial reads will be assembled into draft genomes using Flye, an assembler specifically designed for long-read sequencing technologies.

Genome assembly enables strain-level characterization and downstream functional analyses.

---

**Module 6 – Consensus Polishing**

Draft assemblies will be polished using Medaka to improve consensus accuracy and reduce sequencing errors associated with Nanopore reads.

---

**Module 7 – Genome Annotation**

Polished genomes will be annotated using Prokka to identify coding sequences, rRNA genes, tRNA genes, and predicted protein functions.

---

**Module 8 – Antimicrobial Resistance Detection**

Annotated genomes will be screened against the Comprehensive Antibiotic Resistance Database (CARD) and/or ResFinder to identify antimicrobial resistance genes and associated resistance mechanisms.

---

**Module 9 – Virulence Factor Detection**

Virulence-associated genes will be identified using the Virulence Factor Database (VFDB), allowing rapid assessment of pathogen pathogenicity and potential public health risk.

---

**Module 10 – Automated Reporting**

The final module will automatically generate an interactive report summarizing:

* Sequencing quality metrics
* Taxonomic composition
* Pathogen identification
* Relative abundance profiles
* Genome assembly statistics
* Antimicrobial resistance genes
* Virulence factors
* Interactive Krona visualizations
* Exportable PDF and HTML reports

The report will provide an integrated summary suitable for routine food safety monitoring and outbreak investigations.

---

## Computational Framework

FoodNanoDetect will be developed using the Nextflow workflow management system. Individual analytical modules will be containerized using Docker or Conda environments to ensure reproducibility across different computational platforms.

The modular architecture allows independent updating of each analysis component while maintaining a standardized end-to-end workflow.

---

## Expected Deliverables

The proposed project will generate:

* A standardized Oxford Nanopore shotgun metagenomic workflow for food safety applications.
* FoodNanoDetect, an open and reproducible bioinformatics pipeline for pathogen detection.
* Automated computational workflows for microbial classification, genome assembly, antimicrobial resistance analysis, and virulence profiling.
* Standard operating procedures for laboratory and computational analyses.
* Automated reporting tools suitable for routine surveillance, shelf-life studies, environmental monitoring, and outbreak investigations.

---

## Expected Impact

FoodNanoDetect will provide a rapid, culture-independent platform for comprehensive microbial surveillance in food systems. By integrating Oxford Nanopore sequencing with automated bioinformatics analysis, the proposed platform will substantially reduce analysis time while improving the detection of unculturable microorganisms and enhancing strain-level characterization.

The modular design will facilitate future expansion to include machine learning-based spoilage prediction, contamination source tracking, quantitative microbial risk assessment, and predictive food safety analytics. Ultimately, FoodNanoDetect has the potential to become a standardized computational framework supporting food manufacturers, regulatory agencies, and research laboratories in modern food safety surveillance.


These advantages make ONT particularly suitable for food safety surveillance, environmental monitoring, and outbreak investigations.


##  Oxford ONT MinION and required kits
### Device and Kits

| Item                                                            | Purpose                                                                                                                                                                                                                                        |      Needed for Your Project?     |
| --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------: |
| **MinION Mk1D**                                                 | The sequencing device that connects to your computer and performs real-time nanopore sequencing.                                                                                                                                               |            ✅ Essential            |
| **R10.4.1 DNA Flow Cells (FLO-MIN114)**                         | The consumable chip containing thousands of nanopores. DNA molecules pass through these pores to generate sequencing data. One flow cell is typically used per sequencing run (although it can sometimes be washed and reused).                |            ✅ Essential            |
| **Ligation Sequencing Kit V14 (SQK-LSK114)**                    | Library preparation kit. It repairs DNA ends, adds sequencing adapters and motor proteins so DNA can enter the nanopores. This is the recommended kit for **shotgun metagenomics** because it produces the highest yield and longest reads.    |            ✅ Essential            |
| **Native Barcoding Kit 24 (SQK-NBD114.24)** *(optional add-on)* | Adds unique DNA barcodes to each sample, allowing multiple samples (e.g., 2–24) to be pooled and sequenced on the same flow cell. After sequencing, the software separates the reads by barcode (demultiplexing).                              |           ✅ Recommended           |
| **Flow Cell Wash Kit**                                          | Cleans residual DNA from a used flow cell so it can potentially be reused for another run if sufficient nanopores remain active. This helps reduce consumable costs.                                                                           |              ✅ Useful             |
| **Control Expansion Kit**                                       | Contains a control DNA sample (typically lambda phage DNA) used to verify that the sequencing chemistry, flow cell, and instrument are functioning properly during initial setup or troubleshooting. It is **not** used for your food samples. | ⚪ Optional (included in the pack) |

### Library Preparation 

Convert purified genomic DNA into a sequencing-ready library by attaching Oxford Nanopore sequencing adapters to DNA fragments, enabling their recognition and translocation through nanopores during sequencing.


<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/26b8f745-9119-4904-9928-813577599385" />

#### Step 1. DNA End Repair & dA-Tailing

   DNA extracted from samples often has uneven or damaged ends. This step repairs those ends and adds a single adenine (A) overhang to each DNA fragment, creating compatible ends for adapter ligation.

- Reagent: Included in the Ligation Sequencing Kit V14.

- Output: Uniform DNA molecules ready for adapter attachment.
#### Step 2. Adapter Ligation
  
  Oxford Nanopore sequencing adapters are ligated onto both ends of each DNA fragment.

These adapters contain:
- Motor proteins that regulate DNA translocation through the nanopore.
- Sequencing adapters recognized by the MinION instrument.

Without these adapters, DNA cannot be sequenced.
- Reagent: Included in the Ligation Sequencing Kit V14.
- Output Sequencing-ready DNA library.

#### Step 3. Magnetic Bead Cleanup

Purify the library by removing excess enzymes, free adapters, salts, and short DNA fragments. This step improves sequencing efficiency and data quality.

- Reagent:  AMPure XP beads (or equivalent magnetic beads).
- Output: Clean, high-quality sequencing library.
  
#### Step 4. Native Barcoding (Optional)

If sequencing multiple samples simultaneously, unique barcode sequences are ligated to each sample before adapter ligation (or according to the kit workflow).
| Sample             | Barcode |
| ------------------ | ------- |
| Chicken breast     | BC01    |
| Spinach            | BC02    |
| Milk               | BC03    |
| Environmental swab | BC04    |

After sequencing, reads are separated computationally based on these barcodes.

- Kit: Native Barcoding Kit 24 (SQK-NBD114.24)

**This library is then loaded onto an R10.4.1 flow cell for sequencing on the MinION Mk1D.**
