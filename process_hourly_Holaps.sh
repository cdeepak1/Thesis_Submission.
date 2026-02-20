#!/bin/bash
#SBATCH -J holaps-hourly-parallel
#SBATCH -D /data/twd_data/HOLAPS/2001-2020/hourly
#SBATCH -o /work/chinthap/holaps-hourly-parallel-%j.log
#SBATCH -p compute
#SBATCH -t 2:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=8
#SBATCH --mail-type=END,FAIL

module purge
module load GCC/12.2.0 OpenMPI/4.1.4 CDO/2.2.2 parallel/20230722

cd /data/twd_data/HOLAPS/2001-2020/hourly

echo "Starting hourly to monthly processing at: $(date)"

# Function to process one hourly file
process_hourly_file() {
    folder=$1
    file=$2
    cd "/data/twd_data/HOLAPS/2001-2020/hourly/$folder"
    output_file="${file/_hourly_d1/_monthly}"
    
    if [ ! -f "$output_file" ]; then
        echo "Processing: $file"
        cdo monmean "$file" "$output_file"
        echo "Completed: $output_file"
    else
        echo "Skipping: $output_file (exists)"
    fi
}

export -f process_hourly_file

# Process each folder
for folder in "LE" "SM" "H"; do
    if [ -d "$folder" ]; then
        echo "=== Processing $folder with GNU Parallel ==="
        cd "$folder"
        
        # Create list of files to process
        for file in HOLAPS-${folder}-Europe-*_hourly_d1.nc; do
            if [ -f "$file" ]; then
                echo "$folder $file"
            fi
        done | parallel -j 8 --colsep ' ' --joblog parallel_${folder}.log process_hourly_file {1} {2}
        
        cd ..
    fi
done

echo "All processing completed at: $(date)"
