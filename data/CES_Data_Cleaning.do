/********************************************************************
ECB Consumer Expectations Survey (CES) — Monthly data 2020–2025
Source: https://www.ecb.europa.eu/stats/ecb_surveys/consumer_exp_survey/html/data_methodological.en.html

*Please read Microdata Guide carefully: https://www.ecb.europa.eu/stats/ecb_surveys/consumer_exp_survey/shared/pdf/ecb.CES_microdata_guide.en.pdf?e0a903405101d4ea93e4c2ceb34abefd

*Download Monthly Data from 2020-2025
*Download Background Data

Goal:
1) Import monthly CES files (2020–2025)
2) Append them into one dataset
3) Merge with background data (respondent characteristics)
4) Create a monthly date variable (datem) from survey round
5) Save a final file for analysis
********************************************************************/

clear all
set more off

cd "c:\Users\Linh Nguyen\OneDrive\GFE2024\Lecture\Macroeconomics_with_Micro_Data\Assignment\ECB Consumer Expectations Survey"


*---------------------------------------------------------------*
* 0) File names (edit only if your filenames differ)
*---------------------------------------------------------------*
local years 2020 2021 2022 2023 2024 2025
local monthly_stub "ecb.CES_data_"
local monthly_tail "_monthly.en.csv"
local background_file "ecb.CES_data_background.en.csv"

*---------------------------------------------------------------*
* 1) Import monthly data for each year and save as .dta
*---------------------------------------------------------------*
foreach y of local years {

    di "=== Importing monthly CES file for year `y' ==="
    import delimited "`monthly_stub'`y'`monthly_tail'", clear

    gen year = `y'
    save "monthly_`y'.dta", replace
}

*---------------------------------------------------------------*
* 2) Import background data and save
*---------------------------------------------------------------*
di "=== Importing background CES file ==="
import delimited "`background_file'", clear
sort a0010
save "background.dta", replace


*---------------------------------------------------------------*
* 3) Append all monthly datasets into one file
*---------------------------------------------------------------*
di "=== Appending monthly datasets 2020–2025 ==="
use "monthly_2020.dta", clear
foreach y of local years {
    if `y' != 2020 {
        append using "monthly_`y'.dta"
    }
}

sort a0010
save "ces_2020_2025.dta", replace

*---------------------------------------------------------------*
* 4) Merge monthly data with background data
*    Key: a0010 (respondent id)
*---------------------------------------------------------------*
use "ces_2020_2025.dta", clear
merge m:1 a0010 using "background.dta"

* Check merge outcome:
tab _merge
* 1 = monthly only, 2 = background only, 3 = matched

* Keep only matched observations (recommended for analysis)
keep if _merge == 3
drop _merge

*---------------------------------------------------------------*
* 5) Create survey_round and monthly date (datem)
*---------------------------------------------------------------*
gen survey_round = a0030
order survey_round, after(a0030)

* CES monthly rounds start at:
* survey_round == 4  <-> April 2020
* So we can compute datem as (Apr 2020) + (survey_round - 4)
gen datem = ym(2020, 4) + (survey_round - 4)
format datem %tm
order datem, after(survey_round)

*---------------------------------------------------------------*
* 6) Final save
*---------------------------------------------------------------*
order year, after(a0030)
save "ces_2020_2025.dta", replace

di "=== Done. Final file saved as ces_2020_2025.dta ==="
