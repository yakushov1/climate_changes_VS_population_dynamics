**Статус проекта : завершен.** <br />
Перед вами исходный код проведенного анализа влияния климатических параметров на режимы динамики
мелких млекопитающих центральной Сибири. Результаты являются основой одной из глав
[диссертации на соискание ученой степени кандидата биологических наук](<https://sev-in.ru/sites/default/files/2024-12/%D0%AF%D0%BA%D1%83%D1%88%D0%BE%D0%B2_%D0%B4%D0%B8%D1%81%D1%81%D0%B5%D1%80%D1%82%D0%B0%D1%86%D0%B8%D1%8F_6.12.pdf>).
<br />
В настоящий момент ведется подготовка публикации по результатам исследования в зарубежном журнале, поэтому описание репозитория будет приведено на английском.

## Description
The folder contains a typical RStudio project.<br />

To reproduce all the calculations included in the manuscript, first open the `climateVStype_of_dynamic.RProj` file using RStudio. 
In this case, you will not need to configure the working directories. <br />

---

The `scripts` directory contains all the necessary scripts.
For convenience, they are numbered and named in the same way as the subsections in the "Results" section of the manuscript.
Each file contains the source code for reproducing the calculations and graphs presented in the article.<br />

---

The `images` directory contains the illustrations included in the publication.<br />

---

Finally, the `data` directory contains all the data needed for calculations.<br />

The source code for the primary processing of climate data is available [here](https://github.com/yakushov1/climate_change_source_code) <br />

- `bad_snow_1976_1994.csv`  
  contains 3 columns <br />
 --- `Sn_description`: 1 if the snow was "bad" and 0 if "good". See the manuscript for details. <br />
 --- `Sn` is the depth of the snow cover. <br />
 --- `Tavg` - average temperature <br />

- `bad_snow_2005_2023.csv` <br />
  The same, but for the period 2005-2023. <br />
  The additional diff column indicates the number of temperature transitions through 0 degrees on this day. <br />


- `Bakhta_annualy_temperature.csv` <br />
Data on the average annual temperature at the Bakhta weather station. <br />
 --- `Tavg` - the average annual temperature. <br />
 --- `Tavg_SE` - the standard error of the average  temperature <br />
 --- `Tavg_base` - average temperature for the base period 1961-1990 <br />
 --- `Tavg_base_SE` - standard error of the average for the base period <br />
 --- `Tavg_last_decade` - the average temperature for 2013-2022. <br />
 --- `Tavg_last_decade_SE` - the standard error of the average for this period. <br />
 --- `T_diff` - the difference between Tavg_base and Tavg_last_decade  <br />
 --- `Tavg_roll_mean` - moving average for the entire period <br />
 --- `Tavg_roll_mean_from_1976` - moving average from 1976 <br />


- `Bakhta_monthly_temperature.csv` -The same, but for every month. <br />

- `climate_for_model.csv` <br />
Climatic data for modelling. Contains information about: <br />
 --- `count` - the number of days with unfavorable snow cover (for details, see the manuscript) <br />
 --- `Tavg_X` or `Sn_x`   average temperature or snow depth for month X <br />
 --- `Melt_freeze` - the number of transitions of average daily temperatures through 0 degrees (for details, see the manuscript) <br />
 --- `Autumn or Spring` - the duration of "autumn" and "spring", calculated by the steady transition of average daily temperatures through 0. The details are also in the manuscript.
<br />
- `numbers_of_days_with_bad_snow.csv` <br />
The number of days with unfavorable snow cover (details in the manuscript). <br />
 --- `count` is the number of such days <br />
 --- `catch` is the type of dynamics (cyclical or non-cyclical). The type of dynamics for a particular year has been determined in  [previous published article](https://onlinelibrary.wiley.com/doi/10.1111/1749-4877.12770).
<br /> 
- `survival_rate_higher_than_the_median.csv`  <br /> 
A list of years for 4 dominant species when winter mortality was higher than the median.



