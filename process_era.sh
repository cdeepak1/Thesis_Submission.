#!/bin/bash
#SBATCH -J era5-seq
#SBATCH -D /data/twd_data/ERA5/ERA5-Land_monthly
#SBATCH -o /work/chinthap/era5-seq-%j.log
#SBATCH -p compute
#SBATCH -t 1:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=2

module purge
module load GCC/12.2.0 OpenMPI/4.1.4 CDO/2.2.2

cd /data/twd_data/ERA5/ERA5-Land_monthly

echo "Starting sequential processing at: $(date)"

# Process variables one by one
echo "1. Sensible heat flux (H)..."
cdo -chname,sshf,H -sellonlatbox,-10,40,35,75 -selyear,2001/2020 surface_sensible_heat_flux.nc H_Europe_2001_2020.nc
echo "   ✓ Created H_Europe_2001_2020.nc"

echo "2. Latent heat flux (LE)..."
cdo -chname,slhf,LE -sellonlatbox,-10,40,35,75 -selyear,2001/2020 surface_latent_heat_flux.nc LE_Europe_2001_2020.nc
echo "   ✓ Created LE_Europe_2001_2020.nc"

echo "3. Air temperature (Ta) - converting K to °C..."
cdo -subc,273.15 -chname,t2m,Ta -sellonlatbox,-10,40,35,75 -selyear,2001/2020 2m_temperature.nc Ta_Europe_2001_2020.nc
echo "   ✓ Created Ta_Europe_2001_2020.nc"

echo "4. Surface temperature (Ts) - converting K to °C..."
cdo -subc,273.15 -chname,skt,Ts -sellonlatbox,-10,40,35,75 -selyear,2001/2020 skin_temperature.nc Ts_Europe_2001_2020.nc
echo "   ✓ Created Ts_Europe_2001_2020.nc"

echo "5. Soil temperature (Td) - converting K to °C..."
cdo -subc,273.15 -chname,stl1,Td -sellonlatbox,-10,40,35,75 -selyear,2001/2020 soil_temperature_level_1.nc Td_Europe_2001_2020.nc
echo "   ✓ Created Td_Europe_2001_2020.nc"

echo "6. Precipitation (rain) - converting m to mm..."
cdo -mulc,1000 -chname,tp,rain -sellonlatbox,-10,40,35,75 -selyear,2001/2020 total_precipitation.nc rain_Europe_2001_2020.nc
echo "   ✓ Created rain_Europe_2001_2020.nc"

echo "7. Soil moisture layer 1 (sm1)..."
cdo -chname,swvl1,sm1 -sellonlatbox,-10,40,35,75 -selyear,2001/2020 volumetric_soil_water_layer_1.nc sm1_Europe_2001_2020.nc
echo "   ✓ Created sm1_Europe_2001_2020.nc"

echo "8. Soil moisture layer 2 (sm2)..."
cdo -chname,swvl2,sm2 -sellonlatbox,-10,40,35,75 -selyear,2001/2020 volumetric_soil_water_layer_2.nc sm2_Europe_2001_2020.nc
echo "   ✓ Created sm2_Europe_2001_2020.nc"

echo "9. Soil moisture layer 3 (sm3)..."
cdo -chname,swvl3,sm3 -sellonlatbox,-10,40,35,75 -selyear,2001/2020 volumetric_soil_water_layer_3.nc sm3_Europe_2001_2020.nc
echo "   ✓ Created sm3_Europe_2001_2020.nc"

echo "10. Soil moisture layer 4 (sm4)..."
cdo -chname,swvl4,sm4 -sellonlatbox,-10,40,35,75 -selyear,2001/2020 volumetric_soil_water_layer_4.nc sm4_Europe_2001_2020.nc
echo "   ✓ Created sm4_Europe_2001_2020.nc"

echo "11. Soil moisture level 1 (sm5)..."
cdo -chname,swvl1,sm5 -sellonlatbox,-10,40,35,75 -selyear,2001/2020 volumetric_soil_water_level_1.nc sm5_Europe_2001_2020.nc
echo "   ✓ Created sm5_Europe_2001_2020.nc"

echo "12. Net solar radiation (solar)..."
cdo -chname,ssr,solar -sellonlatbox,-10,40,35,75 -selyear,2001/2020 surface_net_solar_radiation.nc solar_Europe_2001_2020.nc
echo "   ✓ Created solar_Europe_2001_2020.nc"

echo "13. Net thermal radiation (thermal)..."
cdo -chname,str,thermal -sellonlatbox,-10,40,35,75 -selyear,2001/2020 surface_net_thermal_radiation.nc thermal_Europe_2001_2020.nc
echo "   ✓ Created thermal_Europe_2001_2020.nc"

echo "14. Net radiation (Rn = solar + thermal)..."
cdo add solar_Europe_2001_2020.nc thermal_Europe_2001_2020.nc Rn_temp.nc
cdo chname,solar,Rn Rn_temp.nc Rn_Europe_2001_2020.nc
rm Rn_temp.nc
echo "   ✓ Created Rn_Europe_2001_2020.nc"

echo ""
echo "All processing completed at: $(date)"
echo ""
echo "Files created:"
ls -lh *_Europe_2001_2020.nc
echo ""
echo "Total files created: $(ls *_Europe_2001_2020.nc 2>/dev/null | wc -l)"
