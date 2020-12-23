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

The pipeline is composed of five steps.

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
    
  - **R 3.0 and above**
    - Libraries 
      - TransPhylo
      - ape
      - lubridate

[Back To The Top](#table-of-contents)

---
