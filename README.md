# FoodNanoDetect: An Oxford Nanopore-Based Shotgun Metagenomic Pipeline for Rapid Foodborne Pathogen Detection and Surveillance

## 1. Background

Foodborne pathogens remain one of the major challenges in food production and food safety. Conventional microbiological methods rely heavily on culturing, which is labor-intensive and often requires several days before pathogens can be identified. Furthermore, numerous microorganisms present in food products and processing environments are difficult or impossible to culture, resulting in incomplete microbial characterization.

Current molecular approaches, including 16S rRNA sequencing, ITS sequencing, whole genome sequencing (WGS), and Illumina shotgun metagenomics, have substantially improved microbial surveillance. However, these methods have several limitations:

Amplicon sequencing provides limited taxonomic resolution and cannot reliably distinguish closely related pathogenic strains.
Illumina shotgun sequencing offers high accuracy but requires lengthy library preparation, external sequencing facilities, and computationally intensive analysis.
Whole genome sequencing requires successful isolation of individual organisms, making it unsuitable for unculturable microorganisms.

Recent advances in Oxford Nanopore Technologies (ONT) have made long-read shotgun metagenomic sequencing an attractive alternative. Nanopore sequencing provides:
- Real-time sequencing
- Portable instrumentation
- Long-read sequencing
- Rapid turnaround
- Direct detection of unculturable microorganisms
- Improved genome assembly and strain-level identification

These advantages make ONT particularly suitable for food safety surveillance, environmental monitoring, and outbreak investigations.

<img width="1500" height="650" alt="image" src="https://github.com/user-attachments/assets/5c0a4754-c0b4-4155-91fb-e5a511f08ce9" />

## 2. Objectives

The objective of this project is to establish an end-to-end Oxford Nanopore shotgun metagenomic workflow for rapid detection and monitoring of foodborne pathogens.

Specific objectives include:
- Establish Oxford Nanopore sequencing workflows optimized for complex food microbiomes.
- Build a bioinformatics pipeline for data analysis
- Validate the pipeline using known foodborne pathogens and naturally contaminated food samples from NCBI.

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/ac8e92b2-292d-411a-8e42-16bd38cece76" />

## 3. Oxford ONT MinION and required kits
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
## 4. Bioinformatics Pipeline: 

We here propose to adapt the published IDseq (CZ ID) metagenomic pathogen detection workflow for Oxford Nanopore long-read sequencing. While the original IDseq platform was primarily developed for Illumina-based metagenomic datasets, our pipeline will incorporate Oxford Nanopore-specific preprocessing (Dorado basecalling, NanoFilt quality filtering, and long-read genome assembly) while retaining the robust taxonomic classification and pathogen identification framework established by IDseq. Additional modules for antimicrobial resistance gene detection, virulence profiling, and automated reporting will be integrated to support routine food safety surveillance.


