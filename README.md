# COVID-19 Data Exploration

## Overview

This project analyzes the COVID-19 dataset from [Our World in Data](https://ourworldindata.org/explorers/coronavirus-data-explorer) to gain insights into global vaccination rates and case fatality rates. The dataset provides valuable information on COVID-19 cases, vaccinations, and fatalities in various countries.

## Data Source

The data used in this project was obtained from [Our World in Data](https://ourworldindata.org/explorers/coronavirus-data-explorer). You can download the dataset from the following link: [COVID-19 Data Download](https://ourworldindata.org/explorers/coronavirus-data-explorer?zoomToSelection=true&time=2020-03-01..latest&facet=none&pickerSort=asc&pickerMetric=location&Metric=Confirmed+cases&Interval=7-day+rolling+average&Relative+to+Population=true&Color+by+test+positivity=false&country=USA~GBR~CAN~DEU~ITA~IND).

## Installation

To run this project, you'll need:

- Microsoft Excel for initial data exploration.
- Microsoft SQL Server to execute SQL queries.

## Usage

**Data Exploration**:
   - Start by downloading the dataset from the provided link.
   - Load the dataset into Microsoft Excel to get familiar with the data.

**Data Import**:
   - Import the Excel file into Microsoft SQL Server, which will be used for this project.

**Objectives**:
   - The SQL file in this repository contains queries to extract insights such as:
     - Global Vaccination Report by Countries.
     - Percentage of the Population Vaccinated by Countries.
     - Global Case Fatality by Countries.
     - Case Fatality in Nigeria.
     - Vaccination Report in Nigeria.
   - Execute the SQL queries to retrieve the desired information.

## Folder Structure

- **/data**: Store the dataset here.
- **/sql**: Contains the SQL queries used for analysis.
- **/results**: Save visualizations and summary reports here.

## Acknowledgments

- Our World in Data for providing the COVID-19 dataset.
- Contributors to open-source libraries used in this project.

## Contact Information

For questions or feedback, please contact me on [LinkedIn](https://www.linkedin.com/in/frankolanari/).
