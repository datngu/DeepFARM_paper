# DeepFARM: Deep learning for regulatory sequence modeling in farm animals

This repository contains data analysis codes for the DeepFARM project, which applies deep learning models (DanQ and DeepSEA) to predict regulatory elements in farm animal genomes including cattle, pig, chicken, and salmon.

## Overview

DeepFARM is part of the manuscript: "Sequence-based chromatin activity modeling and regulatory impact prediction of genetic variants in farmed animals using deep learning". This pipeline leverages the power of [Nextflow](https://www.nextflow.io/) for scalable and reproducible workflows, enabling researchers to analyze chromatin accessibility patterns and predict the regulatory impact of genetic variants in livestock species.


The project includes:

- Model training and evaluation for DanQ and DeepSEA architectures
- Motif analysis and interpretation of learned CNN kernels
- Causal variant prediction using fine-mapping data
- Genomic selection applications for salmon breeding

## Dataset Information

The project analyzes ChIP-seq and ATAC-seq data across four species:

| Species | Total Tracks | ATAC/DNaseSeq | CTCF/DMC1 | H3K27ac | H3K27me3 | H3K36me3 | H3K4me1 | H3K4me3 |
|---------|--------------|---------------|-----------|---------|----------|----------|---------|---------|
| Cattle  | 95           | 15            | 16        | 16      | 16       | 0        | 16      | 16      |
| Chicken | 97           | 17            | 16        | 16      | 16       | 0        | 16      | 16      |
| Pig     | 80           | 16            | 0         | 16      | 16       | 0        | 16      | 16      |
| Salmon  | 301          | 48            | 56        | 47      | 47       | 9        | 47      | 47      |

## Repository Structure

### Notebooks and Scripts
- `0.dataset_info.ipynb` - Dataset information and track statistics
- `1.Model_performance_data_processing.ipynb` - Model evaluation data processing
- `1.plotting.R` - R script for generating performance plots
- `2.extract_CNN_kernels.ipynb` - CNN kernel extraction for motif analysis
- `2.motif_analysis.ipynb` - Motif analysis using TomTom
- `3.Causal_variant_prediction.ipynb` - Fine-mapping variant prediction analysis
- `4.SAD_cattle.ipynb` - Sequence Activity Difference analysis for cattle
- `5.Salmon_GS.R` - Genomic selection analysis for salmon

### Data Directory
- `data/data_info/` - Track names and metadata for each species
- `data/model_evals/` - Model performance evaluation results
- `data/susie/` - Fine-mapping results from SuSiE analysis
- `data/susie_vip/` - Variant impact prediction scores
- `data/tomtom/` - Motif analysis results

### Model Weights
- `model_weights/` - MEME format motif files extracted from trained models

### Output Files
- `out_figs/` - Generated figures (PDF/PNG format)
- `out_tables/` - Summary tables and results (CSV format)

## Pre-trained Models

Model weights of DanQ for cattle, pig, chicken, and salmon are available at:

- [Cattle DanQ model](https://github.com/datngu/data/releases/download/v.0.0.4/cattle_DanQ.h5)
- [Chicken DanQ model](https://github.com/datngu/data/releases/download/v.0.0.4/chicken_DanQ.h5)
- [Pig DanQ model](https://github.com/datngu/data/releases/download/v.0.0.4/pig_DanQ.h5)
- [Salmon DanQ model](https://github.com/datngu/data/releases/download/v.0.0.4/salmon_DanQ.h5)

## Key Results

### Model Performance
- DanQ and DeepSEA models were trained with different learning rates (5e-05, 1e-04, 5e-04, 1e-03)
- Performance evaluated using AUROC across all chromatin features
- Results show species-specific performance patterns

### Motif Discovery
- CNN kernels successfully identify known transcription factor binding motifs

### Causal Variant Prediction
- Integration with fine-mapping results for functional variant prioritization


### Genomic Selection
- Application to salmon breeding demonstrates utility for aquaculture
- Comparison of different SNP selection strategies for genomic prediction

## Requirements

### Python Dependencies
- pandas
- numpy
- matplotlib
- scikit-learn
- tensorflow/keras (for model training)
- joblib

### R Dependencies
- data.table
- ggplot2
- dplyr
- tidyr

## Usage

1. **Dataset Analysis**: Run `0.dataset_info.ipynb` to explore dataset statistics
2. **Model Evaluation**: Use `1.Model_performance_data_processing.ipynb` to process evaluation results
3. **Motif Analysis**: Execute `2.motif_analysis.ipynb` for CNN kernel interpretation
4. **Variant Prediction**: Run `3.Causal_variant_prediction.ipynb` for fine-mapping analysis
5. **Visualization**: Use `1.plotting.R` for generating publication figures

## Citation

Please cite this work if you use DeepFARM in your research.

## License

This project is available under the terms specified in the repository.

