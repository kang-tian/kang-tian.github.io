# The Causal Effect of Receiving Information About the Sequelae of COVID-19 on People’s Preventive Behaviors (2021-2022)

**Kang Tian, McGill University**  
**ECON-664: Applied Cross-Sectional Methods**
***Note***: This is a personal paper. The questionnaire design, data collection, and intervention implementation were carried out collaboratively with two group members, Mingda Li and Jingjie Guo. Due to ethical considerations, the original dataset will remain confidential.
**Link to Code:** https://github.com/kang-tian/AB_Test_CausalEffect_COVID_Info_on_Behavior

<p> &nbsp;</p>

## Abstract

This study examines how information about COVID-19 sequelae affects preventive behaviors and risk perception. Using a randomized experiment combined with Difference-in-Difference (DID) analysis, we constructed novel preventive and risk perception indexes. Results show heterogeneous effects based on initial preventive consciousness, gender, and national background. Prior COVID exposure (self or relatives/friends) also influences behavior.

<p> &nbsp;</p>

## 1. Introduction

COVID-19 continues to spread globally despite public health measures. While people are exposed to extensive COVID-related information daily, it is unclear whether specific health-related information (like sequelae) effectively improves preventive behaviors. This study investigates whether clear, targeted information on long-term health consequences motivates higher preventive action, measured through novel indexes: **Total Preventive Index (TPI)**, **Personal Preventive Index**, and **Public Preventive Index**.

<p> &nbsp;</p>

## 2. Background

We focus on health-related information because it directly affects individuals. Three challenges arise:

1. Medical reports are complex and not fully conveyed by media.  
2. People receive multiple types of COVID-related information simultaneously.  
3. Low-preventive-consciousness individuals may ignore health warnings.  

Randomized experiments can isolate the causal effect of targeted health information.

<p> &nbsp;</p>

## 3. Experimental Design & Workflow

**Participants:** 31 students in McGill University.  
**Design:** Baseline survey → Randomization into treatment/control → Information intervention → Endline survey → DID analysis.
### Workflow 
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture0.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>


**Baseline Survey:**
- Collect personal characteristics: age, gender, nationality, prior COVID exposure.
- Measure preventive behaviors (last 7 days) using 18 indicators (5-scale Likert).
- Construct TPI, **Personal Preventive Index** (12 indicators with the weight of 2/3), and **Public Preventive Index** (6 indicators with the weight of 1/3).
- Measure risk perception using a 5-scale index.
#### Questionnaire Design & The Construction of TPI
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture3.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>


**Randomization:**
- The participants were divided into two groups: Control Group and Treatment Group
- Both groups successfully passed the balance test.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture2.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>
- Stratified by baseline TPI to balance low, medium, high preventive behavior participants.

**Intervention:**
- Treatment group receives daily messages detailing sequelae of COVID-19 for two weeks.
- Control group receives neutral COVID-related messages unrelated to sequelae.
#### Intervention Messages
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture4.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>

**Endline Survey:**
- Repeat TPI, subindexes, and risk perception measures.
- Include attention check questions to confirm exposure.

**Model:**

<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture5.png" alt="Reviews per Page" width="70%"/>
</p>

- Coefficient of interest: \(\beta_1\) (DID effect).
<p> &nbsp;</p>

**Validation:**
- Fisher test, multiple hypothesis correction, and attrition tests confirm robustness.
<p> &nbsp;</p>

## 4. Results

### 4.1 Primary Outcome
- **Total Preventive Index:** Negative but insignificant effect (-0.037).  
- **Personal vs. Public Index:** Offset effect—Personal decreases, Public increases (both insignificant).  
- **Prior COVID exposure:** Reduces personal prevention but increases public preventive behaviors.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture1.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture6.png" alt="Reviews per Page" width="70%"/>
</p>


### 4.2 Heterogeneous Effects

#### 4.2.1 By Initial Preventive Index
- Low/medium baseline: Intervention increases total/public preventive index slightly.  
- High baseline: Intervention reduces preventive index (significant for Public Preventive Index).
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture7.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>

#### 4.2.2 By Gender
- Females: Intervention significantly increases Public Preventive Index.  
- Males: Effect negative but insignificant.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture8.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>

#### 4.2.3 By National Background
- Local vs. international students show varying responsiveness; close relatives/friends contracting COVID raises Public Preventive Index more for locals.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture9.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>


### 4.3 Effect of Intervention on Secondary Outcome
- The intervention slightly increased the Risk Perception Index (+0.248) but not significantly. Those who had contracted COVID had higher risk perception, while those with close relatives/friends affected had lower. Subgroup analysis shows medium- and high-preventive individuals are more responsive to external factors.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture10.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>

### 4.4 Comprehension of Intervention
- Most treated participants reported strong understanding. Higher comprehension is associated with smaller decreases in preventive indexes but a higher drop in risk perception. Sample size is too small for regression.
<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture11.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>

### 4.5 Robustness Check
Dropping control participants exposed indirectly shows signs remain consistent, though magnitudes change. Primary outcomes are less robust, but the Risk Perception Index is more robust.

<p align="center">
  <img src="/projects/AB_Test_CausalEffect_COVID_Info_on_Behavior/images/Picture12.png" alt="Reviews per Page" width="60%"/>
</p>
<p> &nbsp;</p>

## 5. Discussion

- Effectiveness of sequelae information is context-dependent, influenced by baseline behavior, gender, and social proximity to COVID cases.  
- Public preventive behaviors are more responsive than personal ones.  
- **Policy implication:** Targeted information campaigns could improve societal preventive behavior.
<p> &nbsp;</p>

## 6. Conclusion

- Novel preventive and risk perception indexes allow quantifying behavior changes.  
- Heterogeneous effects suggest policymakers should tailor COVID information based on audience characteristics.  
- **Future work:** Larger samples, external validity checks, and longitudinal designs.
<p> &nbsp;</p>
