# TransCOVID

**A dedicated pipeline designed for the inference of COVID19 transmission networks in a population complete with the prediction of unsampled sources of infection using SARS-CoV-2 genomic sequences. The pipeline has undergone intensive parameter optimization aimed to capture the infection dynamics of the SARS-CoV-2 virus. Our pipeline is built upon the BEAST2 and TransPhylo software.**

---

### Table of Contents

- [Description](#description)
- [Getting Started](#getting-started)
- [Procedure](#procedure)
- [License](#license)
- [Authors](#author-info)
- [Citations](#citations)
---

## Description

### A novel computational approach to the deconstruction of COVID19 infection dynamics through the inference of unsampled sources of infection.

The following pipeline will provide health care professionals with a novel approach to infer transmission networks, complete with the ability to predict the presence of unsampled sources of infection. 

The pipeline is composed of five steps as shown in the flowchart below. 

![alt text](https://github.com/theLongLab/TransCOVID/blob/main/Procedure_overview.png)

#### Protocol outline

1. Date extraction
2. Multiple Sequence Alignment (MSA)
3. Parameterization and phylogenetic inference 
4. Transmission tree generation
5. Data visualization. 

A bespoke R script  was written to conduct **Step 4** or the TransPhylo analysis. The process is automated and one can simply execute the entire process.

- The R scripts' main goal is to extract the summary statistics about the topology of the inferred transmission trees and extract the transmission network.

These scripts are highly commented and can be easily modified to extract what you want from the TransPhylo ctree object.

[Back To The Top](#table-of-contents)

---

## Getting Started

### Prerequisites
- **Required Software**

  - **BEAST2 package**
    - BDSKY
    - LogCombiner
    - Tracer
    - TreeAnnotator 
    
  - **R 3.0 and above**
    - Libraries 
      - TransPhylo
      - ape
      - lubridate

  - **FigTree**
  - **Gephi**

[Back To The Top](#table-of-contents)

---

## Procedure

#### 1. Data extraction and filtering

FASTA sequences were obtained through [GISAID](https://www.gisaid.org/). Data was filtered based on Host, Sequence coverage, Sequence completeness and Date of sample collection. 

#### 2. Multiple Sequence Alignment (MSA)

The filtered FASTA sequences were then subjected to MSA which was performed using [Multiple Alignment using Fast Fourier Transform](https://mafft.cbrc.jp/alignment/server/) (MAFFT).

#### 3.	Phylogenetic parameter selection

The selected BEAST2 parameters were set-up using Beauti. The analysis was conducted with activated tip dates, a Generalized Time Reversible (GTR) site model with a gamma category count of 4, a relaxed clock model and a Birth Death Skyline Serial model as the prior.

>The file **xml_sample.xml** contains a sample Beauti file with the selected parameters.

#### 4.	Phylogenetic tree generation

Best results were observed with MCMC chain lengths of 1 billion. This was conducted by combining 10 separate runs of chain length 10<sup>7</sup>. The log and trees files were later combined using LogCombiner.

The validity of the MCMC run was evaluated using Tracer by reference to the Estimated Sample Size (ESS) of each inferred parameter. It was ensured that the ESS was greater than 200 for each parameter.

Subsequently the phylogenetic tree was extracted through TreeAnnotator using common ancestor node heights and a target tree type of maximum clade credibility and converted to a **newick** format using FigTree.

#### 5.	Transmission tree generation

The resultant phylogenetic tree will then be loaded into TransPhylo and the transmission tree will be extracted using the R code titled **TransmissionX.R**.

>The file **transmissionX_sample.tsv** is a sample obtained from the above R code. 

#### 6.	Visualization of transmission networks

Transmission networks were visualized using Gephi. Before loading the files the Source and Target should be extracted and if required an optional metadata file can too be added.

>The file **source_target.csv** contains the main transmission network to be loaded into Gephi.

> The file **metadata.csv** contains the metadata file to be loaded into Gephi.

The image below shows Canada's transmission network for COVID19 as was produced by our pipleine. 

![alt text](https://github.com/theLongLab/TransCOVID/blob/main/Gephi_output.jpg)

[Back To The Top](#table-of-contents)

---
## License
**This project is licensed under the MIT License**


MIT License

Copyright (c) 2020 The Long Lab

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[Back To The Top](#table-of-contents)

---

## Author Info

See the list of contributors (reference publication to be added) who participated in this project. Didelot et al.: Developed and tested the TransPhylo program.

[Back To The Top](#table-of-contents)

## Citations
_If you found this protocol helpful in your own transmission analyses, please cite (reference publication to be added)._

[Back To The Top](#table-of-contents)
