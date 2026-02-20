# Thesis_Submission.
Code  and supplementary document

code used for the thesis analysis of long-term trends in surface energy fluxes using **FLUXNET/ICOS**, **HOLAPS**, and **ERA5-Land**.

## Contents

### Python (Jupyter notebooks)
- `trends.ipynb` – FLUXNET/ICOS preprocessing, aggregation (yearly/JJA), Mann–Kendall + Sen’s slope trends, diagnostics  
- `trends_tune.ipynb` – tuning/sanity checks for trend settings on sample series  
- `site_analysis.ipynb` – site inventory and data-availability/coverage checks  
- `station_wise_analysis.ipynb` – station-wise trend statistics and outputs/plots  
- `plotting_variables.ipynb` – plotting of station-wise trend markers (sign + significance)  
- `final_station_analysis_venn_diagrams.ipynb` – Venn-diagram co-occurrence analysis (FLUXNET)  
- `CA.ipynb` – trend comparison across FLUXNET vs HOLAPS vs ERA5-Land (Venn/summary plots)  
- `ecosystem1_final.ipynb` – ecosystem-wise (IGBP) stratified trend comparisons  
- `holaps_station_wise.ipynb` – HOLAPS station extraction + QC/debug  
- `holaps_station_wise_final.ipynb` – final HOLAPS netCDF → station-wise CSV extraction

### Bash scripts
- `process_hourly_Holaps.sh` – convert HOLAPS hourly files to monthly means (CDO/parallel)  
- `process_era.sh` – preprocess ERA5-Land monthly fields (CDO), including derived variables

## Supplementary material
- A supplementary PDF (50 station plots) is included in this repository.
