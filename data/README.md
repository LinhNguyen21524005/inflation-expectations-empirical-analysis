# Data Documentation

## 1. Data Source

This project uses microdata from the **European Central Bank (ECB) Consumer Expectations Survey (CES)**.

The original survey data are publicly available through the ECB's official website:

- [ECB Consumer Expectations Survey – Data and Methodological Information](https://www.ecb.europa.eu/stats/ecb_surveys/consumer_exp_survey/html/data_methodological.en.html)

The dataset covers survey observations from 2020 to 2025, focusing on Austria and the Netherlands.

## 2. Dataset Construction

The analytical dataset, `ces_2020_2025.dta`, was constructed by downloading the relevant ECB CES microdata files and combining (merging) them to create a consolidated dataset for empirical analysis.

The construction process involved:

1. Downloading the relevant monthly CES microdata files for 2020–2025.
2. Obtaining the corresponding background data containing individual and household characteristics.
3. Combining the downloaded datasets using the appropriate respondent identifiers.
4. Preparing a consolidated Stata dataset for subsequent data cleaning and econometric analysis.

## 3. Repository Data Files

The following datasets are used in the project:

| File | Description |
|---|---|
| `ces_2020_2025.dta` | Consolidated dataset constructed from the downloaded ECB CES microdata |
| `ces_2020_2025_cleaned.dta` | Cleaned analytical dataset used for empirical analysis |

**Note:** The original and processed microdata files are not distributed through this public repository. Users should obtain the source data directly from the ECB and comply with its applicable data-use conditions.

## 4. Reproducibility

The data preparation and cleaning procedures are documented in the Stata scripts provided in the `scripts/stata/` directory.

Researchers seeking to reproduce the analysis should:

1. Download the relevant CES microdata directly from the ECB.
2. Reconstruct the consolidated dataset using the documented data preparation procedure.
3. Run the provided Stata cleaning and estimation scripts.

## 5. Data Acknowledgement

Source: European Central Bank (ECB), Consumer Expectations Survey (CES).

Users of the data must comply with the ECB's applicable terms of use and acknowledgement requirements.
