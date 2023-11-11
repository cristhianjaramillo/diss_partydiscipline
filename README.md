# Unravelling Party Discipline in the Global South: A Case Study of Peru Using Beta Regression Analysis

Welcome to the GitHub repository for the thesis titled "Unravelling Party Discipline in the Global South: A Case Study of Peru Using Beta Regression Analysis" by Cristhian Jaramillo, conducted as part of the MSc Social Research Methods program at the London School of Economics and Political Science.

## Research Overview

This repository houses all the materials utilized in the creation of the aforementioned thesis. The primary research question addressed in this study is: "Does party control, quantified through party affiliation (independent variable), positively correlate with party discipline (dependent variable) within the Peruvian context (2011 to 2019)?" 

To test this hypothesis and shed light on the research question, the dissertation procures data from the official website of the [Peruvian Parliament](https://www.leyes.congreso.gob.pe) and the [Peruvian National Jury of Elections](https://infogob.jne.gob.pe). The study constructs a party discipline index, focusing exclusively on the voting behaviors of Members of Parliament (MPs) concerning motions of confidence, no confidence, and interpellations. The selection of these specific votes is grounded in their significance and potential impact on both the Parliament and the Executive Cabinet. Given that this index is constrained between 0 and 1, the study employs a **beta regression** to assess the hypothesis.

The predictors of this model encompass party control over its members and various control variables. Within the Peruvian context, the assessment of party control over MPs involves an examination of their affiliation status. Membership affiliation signifies an individual's adherence to the internal regulations stipulated by their party. Therefore, as theorized by scholars, the manifestation of party control can be discerned through the presence or absence of party affiliation. Control variables include Gender, Age, Proportion of Votes, Political Experience, Re-election status, Party Role, and Ruling Party affiliation. These variables were chosen based on their relevance to party discipline literature and their availability on the mentioned websites. The party discipline index was adjusted to prevent exact values of 1, facilitating beta regression, and continuous control variables were standardized.

## Raw Data
The `./Raw Data/` directory contains the original data extracted from confidence, no-confidence, and interpellation motions. Each file in this directory is a PDF recording the voting behavior of each of the 130 MPs.

## Final Data
