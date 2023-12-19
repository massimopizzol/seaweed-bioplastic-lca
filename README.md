# seaweed-bioplastic-lca

This repository contains code and data to reproduce the results in the article:

_Life Cycle Assessment of pilot scale production of seaweed-based plastic_

by Maddalen Ayala^1, Marianne Thomsen^2, Massimo Pizzol^1*

Published in: Algal Research, Volume 71, April 2023, 103036 [https://doi.org/10.1016/j.algal.2023.103036](https://doi.org/10.1016/j.algal.2023.103036)
			

_^1 Danish Center for Environmental Assessment, Department of Planning, Aalborg University, Rendsburggade 14, 9000 Aalborg, Denmark_			

_^2 Department of Food Science, University of Copenhagen, Rolighedsvej 26, 1958 Frederiksberg, Denmark_ 			
			
_*Corresponding author e-mail:_ [massimo@plan.aau.dk](mailto:massimo@plan.aau.dk)


## Structure of repository

**Code**

_lci\_to\_bw2.py_ an importer for lci data in .csv into open source [brightway2 LCA software](https://docs.brightway.dev/en/legacy/index.html)_Seaweed-Bioplastic-LCA.ipynb_ Notebook with the code for the simulation

**Data**
_PS pilot (base).csv ;PS pilot (cellulose).csv ;PS pilot (mannitol).csv ;PS pilot (PLA5).csv ;PS pilot (PLA30).csv ;PS pilot.csv_  Several .csv files as inventory _Seaweed-plastic-inventory.xlsx_ The inventory in Excel

_Seaweed-plastic-inventory-corrected.xlsx_ The inventory in Excel, corrected in 2023 [^1].
**Figures**

_Seaweed-plastic-plots.R_ R script to recreate the stochastic simulation figure 

**Results**

_static_results.csv_ Results of the static LCA

_mc\_CC\_biogenic.csv ;
mc\_CC\_fossil.csv ;
mc\_CC\_total\_summary\_stats.csv ;
mc\_CC\_total.csv_ Results of the stochastic LCA_Differences.csv_ Pairwise differences across alternatives[^1]: The inventory in Excel after correction, see article _Corrigendum to “Life Cycle Assessment of pilot scale production of seaweed-based bioplastic” [Algal Res. 71 (2023) 103036]_ available here : [https://doi.org/10.1016/j.algal.2023.103313](https://doi.org/10.1016/j.algal.2023.103313)

