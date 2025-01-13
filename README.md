# Southern Poverty Law Center Hatemap

Each year since 1990, the SPLC has published an annual census of hate groups and antigovernment groups operating within the United States. The number is one barometer of the level of hate and antigovernment extremist activity in the country. The hate and antigovernment extremist map, which depicts the groups’ approximate locations, is the result of a year of monitoring by analysts and researchers and is published annually. The SPLC tracks both hate groups and antigovernment extremist groups – which, combined, make up some of the most extreme elements of the hard right. These groups often overlap and work alongside one another and often converge around a willingness to engage in political violence, either inflict or accept harm, and deny legally established rights to historically oppressed groups of people. Data is available at their website (https://www.splcenter.org/hate-map). 

We want to know:

1. Which year has had the most identified hate and antigovernment groups between 2000 and 2023?

2. Which state has had the most identified hate and antigovernment groups between 2000 and 2023?

3. Which hate ideology or ideologies have been most identified between 2000 and 2023?

## Data structure
The joined SPLC Hate Map dataset covers the period from 2000 to 2023. It has 21,564 rows and 8 columns, and provides critical data into hate groups across the United States. Its structure includes variables like title, city, state, group, ideology, headquarters, statewide, and year. The data folder contains the raw data as well as the aggreate data to answer the previous questions. To replicate the results use the script splc.R in the scripts folder.

**In 2023, SPLC identified 1,430 hate groups, 205 more groups than in 2022 (1,225) and 831 more groups than in 2000 (599). California, Texas, and Florida are the states with the most hate groups identified in the period, with 1,656, 1,402, and 1,383 respectively. Lastly, Neo-Nazis (3,352), the Ku Klux Klan (2,840), and White Nationalist groups (2,711) are the most hate ideologies identified from 2000 to 2023.**

### Strengths of the SPLC data
The dataset contains information, including temporal (year) and geographic (city, state) variables, and classifications of hate group ideology (ideology). This could be useful for diverse applications, including spatiotemporal analysis and policy development. The aggregate data use to create the figures was created following tidy-data principles and it's saved as a csv file so it can be accessible and compatible with most statistical software and programming languages, including R, Python, and SPSS.

### Challenges to reusability
While the dataset includes clear column names, the metadata lacks crucial details. For instance, the definitions of some columns, such as group, headquarters, and statewide, are unclear. These need to be find at the SPLC website (https://www.splcenter.org/frequently-asked-questions-about-hate-and-antigovernment-groups#hate-antigovernment). NA values in these columns further complicate interpretation and reduces the dataset’s utility for researchers needing complete records.

The absence of licensing information (e.g., CC-BY or CC0) limits users' ability to confidently repurpose the data.

Finally, the geographic attributes city and state do not use standardized codes like FIPS, making integration with other datasets less straightforward. Additionally, temporal data in year would benefit from clarification regarding whether this represents the dataset’s collection year or the group's operational timeline.

### Recommendations for improvement
1. Include a detailed metadata file describing each column’s meaning, data types, and potential missing values. A data dictionary should explain terms like ideology, group, and statewide to mitigate ambiguity.
2. Standardize geographic identifiers such as FIPS codes or geographic coordinates to improve interoperability.
3. Provide information on dataset updates or changes over time, including a version history and changelog.
4. Make the dataset available in multiple formats, such as CSV, JSON, and GeoJSON, to support a broader range of users and software tools.

</br>

## SPLC Identified Hate and Antigovernment Extremist Groups in the United States

![Figure 1. Number of Hate and Antigovernment Extremist Groups in the United States, 2000 - 2023](figures/splc_year_state.svg)
</br>
</br>
</br>
![Figure 2. Number of Hate and Antigovernment Extremist Groups in the United States by Ideology, 2000 - 2023](figures/splc_year_state_ideology.svg)
