
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Welcome to the Main Concept Analysis Web-app

Main Concept Analysis (MCA) is a discourse assessment originally
developed by Nicholas and Brookshire (1995) that measures the
informativeness of a discourse sample on a given topic. This web-app is
intended to facilitate efficient and accurate scoring of main concepts
for both research and clinical practice. The app is written in the
[{shiny}](https://shiny.rstudio.com/) framework. The app is currently in
Beta, and is not yet ready for research or clinical deployment.

Please note, the app ***does not save any data*** from each user
session.

## Installation

mainConcept is an R package. You can install the app locally with:

``` r
library(remotes)
remotes::install_github("rbcavanaugh/MCG")
```

## Using

The app can be run locally by calling:

``` r
library(mainConcept)
run_app()
```

It is also available at \[Website link\]

## Feedback

At this stage, we would appreciate feedback on the app - whether related
to bugs/issues with the app or requested features. Please provide
feedback or report bugs using the issues tab in the github repository.

## About Main Concept Analysis

Main concept checklists for several widely used tasks (including picture
description, picture sequence, story retell, and procedural stimuli)
have been developed based on discourse samples of control speakers
(Richardson & Dalton, 2016; 2020). MCA is a hybrid discourse measure
that provides some information on micro-linguistic features of the
discourse sample as well as more macro-linguistic features about the
overall adequacy of the discourse sample to communicate an intended
message.

MCA has shown good sensitivity in differentiating between controls and
individuals with communication disorders (e.g., Kong, Whiteside, &
Bargmann, 2016; Dalton & Richardson, 2019) and between individuals with
fluent and non-fluent aphasia (Kong et al., 2016). Importantly, studies
have shown that changes in informativeness are associated with treatment
performance (Albright & Purves, 2008; Avent & Austermann, 2003; Coelho,
McHugh, & Boyle, 2000; Cupit, Rochon, Leonard, & Laird, 2010; Stark,
2010) and are associated with listener’s perceptions of communication
quality (Cupit et al., 2010; Ross & Wertz, 1999).

### Scoring Main Concept Analysis

[The full analysis manual can be found
here.](https://drive.google.com/drive/folders/1bxazjgQWx-WD8ELTJjwBm_5IToRpgQhQ).
A searchable HTML version of the manual is here: LINK (note, this
version is only updated 1x/year)

Each main concept consists of several essential elements, corresponding
to the subject, main verb, object (if appropriate), and any subordinate
clauses (Nicholas & Brookshire, 1995). The main concept is assigned one
of 5 codes depending on accuracy and completeness.

<center>

| Code                         | Description                                                                                                                                                           | **Richardson and Dalton, 2016** | **Kong, 2009** |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------:|:--------------:|
| Accurate & Complete (AC)     | contains all elements of the main concept on the checklist with no incorrect information                                                                              |            3 Points             |    3 Points    |
| Accurate & Incomplete (AI)   | contains no incorrect information, but leaves out at least one essential element of the main concept on the checklist                                                 |            2 Points             |    2 Point     |
| Inaccurate & Complete (IC)   | contains at least one incorrect piece of essential information (e.g., “knight” for “prince”) but includes all essential elements of the main concept on the checklist |            2 Points             |    1 Point     |
| Inaccurate & Incomplete (II) | clearly corresponds with a main concept on the checklist but includes at least one incorrect essential element and fails to include at least one essential element    |             1 Point             |    1 Point     |
| Absent (AB)                  | did not produce the main concept                                                                                                                                      |            0 Points             |    0 Points    |

</center>

To our knowledge, norms for AphasiaBank stimuli are only available for
the Richardson & Dalton 2016 scoring system. If using the Kong, 2009
system, scores cannot be compared to the Richardson & Dalton 2016 norms.

Nicholas and Brookshire also developed a series of coding rules to
assist in determining the accuracy and completeness of main concepts.
These coding rules are now supplemented with the published checklists,
which provide common alternatives produced for each main concept, since
there is variability in the syntax and vocabulary that could be used to
produce a main concept. These alternative lists are not comprehensive,
so it is possible that a client may produce an acceptable alternative
that is not in the checklist.

## References

Albright, E., & Purves, B. (2008). Exploring SentenceShaperTM: Treatment
and augmentative possibilities. *Aphasiology*, *22*(7-8), 741-752.

Avent, J., & Austermann, S. (2003). Reciprocal scaffolding: A context
for communication treatment in aphasia. *Aphasiology*, *17*(4), 397-404.

Coelho, C. A., McHugh, R. E., & Boyle, M. (2000). Semantic feature
analysis as a treatment for aphasic dysnomia: A replication.
*Aphasiology*, *14*(2), 133-142.

Cupit, J., Rochon, E., Leonard, C., & Laird, L. (2010). Social
validation as a measure of improvement after aphasia treatment: Its
usefulness and influencing factors. *Aphasiology*, *24*(11), 1486-1500.

Dalton, S. G. H., & Richardson, J. D. (2019). A large-scale comparison
of main concept production between persons with aphasia and persons
without brain injury. *American journal of speech-language pathology*,
*28*(1S), 293-320.

Kong, A. P. H., Whiteside, J., & Bargmann, P. (2016). The Main Concept
Analysis: Validation and sensitivity in differentiating discourse
produced by unimpaired English speakers from individuals with aphasia
and dementia of Alzheimer type. *Logopedics Phoniatrics Vocology*,
*41*(3), 129-141.

Nicholas, L. E., & Brookshire, R. H. (1995). Presence, completeness, and
accuracy of main concepts in the connected speech of non-brain-damaged
adults and adults with aphasia. *Journal of Speech, Language, and
Hearing Research*, *38*(1), 145-156.

Richardson, J. D., & Dalton, S. G. (2016). Main concepts for three
different discourse tasks in a large non-clinical sample. *Aphasiology*,
*30*(1), 45-73.

Richardson, J. D., & Dalton, S. G. H. (2020). Main concepts for two
picture description tasks: an addition to Richardson and Dalton, 2016.
*Aphasiology*, *34*(1), 119-136.

Ross, K. B., & Wertz, R. T. (1999). Comparison of impairment and
disability measures for assessing severity of, and improvement in,
aphasia. *Aphasiology, 13*, 113–124.

Stark, J. A. (2010). Content analysis of the fairy tale Cinderella–A
longitudinal single-case study of narrative production: “From rags to
riches”. *Aphasiology*, *24*(6-8), 709-724.
