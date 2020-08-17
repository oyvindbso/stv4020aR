# Burnside & Dollar (2000) replication documentation

## Variabler data description:
| **Variabelnavn**       | **Beskrivelse**                   |
| ---------------------- | --------------------------------- |
| gdp_growth             | Per-capita GDP growth             |
| aid	                 | Aid/PPP GDP                       |
| policy                 | Quality of the policy environment |
| gdp_pr_capita          | Initial PPP GDP per capita        |
| ethnic_frac	         | Ethnic fractionalization          |
| assasinations	         | Assassinations                    |
| sub_saharan_africa	 | Sub-Saharan Africa                |
| fast_growing_east_asia | East Asia                         |
| institutional_quality  | Institutional quality             |
| m2_gdp_lagged	         | M2/GDP, lagged one period         |
| period	         | Period indicator                  |


## Original model
Den originale modellen, som vist i [Burnside & Dollar (modell 5 OLS)](http://www.jstor.org/stable/117311?seq=1#page_scan_tab_contents). *Per-capita GDP growth*  er avhengig variabel (Y).

| **Variabel**             | **Stigningstall (st.feil)** |
| ------------------------ | --------------------------- |
| Aid                      | -0.02 (0.13)                |
| Aid * policy             |  0.19 (2.61)                |
| Log GDP per capita       | -0.60 (-1.02)               |
| Ethnic fractionalization | -0.42 (-0.57)               |
| Assassinations           | -0.45 (-1.68)               |
| Ethnic * Assassinations  |  0.79 (1.74)                |
| Sub-Saharan Africa       | -1.87 (-2.41)               |
| Fast-growing E. Asia     |  1.31 (2.19)                |
| Institutional quality    |  0.69 (3.90)                |
| M2/GDP lagged            |  0.01 (0.84)                |
| Policy                   |  0.71 (3.63)                |
