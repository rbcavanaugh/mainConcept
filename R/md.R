intro_md <- '## Welcome to the Main Concept Analysis Web-app

Main Concept Analysis (MCA) is a discourse assessment originally developed by Nicholas and Brookshire (1995) that measures the informativeness of a discourse sample on a given topic. Main concept checklists for several widely used tasks (including picture description, picture sequence, story retell, and procedural stimuli) have been developed based on discourse samples of control speakers (Richardson & Dalton, 2016; 2020). MCA is a hybrid discourse measure that provides some information on micro-linguistic features of the discourse sample as well as more macro-linguistic features about the overall adequacy of the discourse sample to communicate an intended message.

MCA has shown good sensitivity in differentiating between controls and individuals with communication disorders (e.g., Kong, Whiteside, & Bargmann, 2016; Dalton & Richardson, 2019) and between individuals with fluent and non-fluent aphasia (Kong et al., 2016). Importantly, studies have shown that changes in informativeness are associated with treatment performance (Albright & Purves, 2008; Avent & Austermann, 2003; Coelho, McHugh, & Boyle, 2000; Cupit, Rochon, Leonard, & Laird, 2010; Stark, 2010) and are associated with listeners perceptions of communication quality (Cupit et al., 2010; Ross & Wertz, 1999).

links: 
        
        - https://drive.google.com/drive/folders/1bxazjgQWx-WD8ELTJjwBm_5IToRpgQhQ

DESCRIPTION OF WHAT THE SHINY APP DOES

ANY OTHER IMPORTANT INFORMATION NEEDED PRIOR TO USING THE INFORMATION
'


scoring_md <- '
### Scoring Main Concept Analysis

Each main concept consists of several essential elements, corresponding to the subject, main verb, object (if appropriate), and any subordinate clauses (Nicholas & Brookshire, 1995). The main concept is assigned one of 5 codes depending on the accuracy (are the essential elements accurate?) and completeness (are essential elements present?) of the production.

- Accurate & Complete (AC) = contains all elements of the main concept on the checklist with no incorrect information
- Accurate & Incomplete (AI) = contains no incorrect information, but leaves out at least one essential element of the main concept on the checklist
- Inaccurate & Complete (IC) = contains at least one incorrect piece of essential information (e.g., "knight" for "prince") but includes all essential elements of the main concept on the checklist
- Inaccurate & Incomplete (II) = clearly corresponds with a main concept on the checklist but includes at least one incorrect essential element and fails to include at least one essential element 
- Absent (AB) = did not produce the main concept

<center>

 Code                         | **Richardson and Dalton, 2016**   | **Kong, 2009**                         
------------------------------|:---------------------------------:|:-------------:
 Accurate & Complete (AC)     | 3 Points                          | 3 Points  
 Accurate & Incomplete (AI)   | 2 Points                          | 2 Point 
 Inaccurate & Complete (IC)   | 2 Points	                        | 1 Point  
 Inaccurate & Incomplete (II) | 1 Point                           | 1 Point                              
 Absent (AB)                  | 0 Points                          | 0 Points 
 
 </center>

To our knowledge, norms for AphasiaBank stimuli are only available for the Richardson & Dalton 2016 scoring system. If using the Kong, 2009 system, scores cannot be compared to the Richardson & Dalton 2016 norms. See Kong et al., 2016 for main concepts, checklists, and norms for additional stimuli.

Nicholas and Brookshire also developed a series of coding rules to assist in determining the accuracy and completeness of main concepts. These coding rules are now supplemented with the published checklists, which provide common alternatives produced for each main concept, since there is variability in the syntax and vocabulary that could be used to produce a main concept. These alternative lists are not comprehensive, so it is possible that a client may produce an acceptable alternative that is not in the checklist.
'
