# The Causal Effect of Receiving Information About the Sequelae of COVID-19 on People’s Preventive Behaviors

**Kang Tian (ID: 261012087), The McGill University**  
**ECON-664: Applied Cross-Sectional Methods**

---

## Abstract

This study examines how information about COVID-19 sequelae affects preventive behaviors and risk perception. Using a randomized experiment combined with Difference-in-Difference (DID) analysis, we constructed novel preventive and risk perception indexes. Results show heterogeneous effects based on initial preventive consciousness, gender, and national background. Prior COVID exposure (self or relatives/friends) also influences behavior.

---

## 1. Introduction

COVID-19 continues to spread globally despite public health measures. While people are exposed to extensive COVID-related information daily, it is unclear whether specific health-related information (like sequelae) effectively improves preventive behaviors. This study investigates whether clear, targeted information on long-term health consequences motivates higher preventive action, measured through novel indexes: **Total Preventive Index (TPI)**, **Personal Preventive Index**, and **Public Preventive Index**.

---

## 2. Background

We focus on health-related information because it directly affects individuals. Three challenges arise:

1. Medical reports are complex and not fully conveyed by media.  
2. People receive multiple types of COVID-related information simultaneously.  
3. Low-preventive-consciousness individuals may ignore health warnings.  

Randomized experiments can isolate the causal effect of targeted health information.

---

## 3. Experimental Design & Workflow

**Participants:** 31 students in ECON 664.  
**Design:** Baseline survey → Randomization into treatment/control → Information intervention → Endline survey → DID analysis.

### Workflow and Questionnaire Design

**Baseline Survey:**
- Collect personal characteristics: age, gender, nationality, prior COVID exposure.
- Measure preventive behaviors (last 7 days) using 18 indicators (5-scale Likert).
- Construct TPI, **Personal Preventive Index** (12 indicators), and **Public Preventive Index** (6 indicators).
- Measure risk perception using a 5-scale index.

**Randomization:**
- Stratified by baseline TPI to balance low, medium, high preventive behavior participants.

**Intervention:**
- Treatment group receives daily messages detailing sequelae of COVID-19 for two weeks.
- Control group receives neutral COVID-related messages unrelated to sequelae.

**Endline Survey:**
- Repeat TPI, subindexes, and risk perception measures.
- Include attention check questions to confirm exposure.

**Model:**

\[
\hat{Y}_{it} = \beta_0 + \beta_1(Post_t \times Treatment_i) + \beta_2 Post_t + \beta_3 X_{it} + \beta_4 ContractedCOVID_{it} + \beta_5 CloseRelativesCOVID_{it} + \beta_6 ExposureInfo_{it}
\]

- Coefficient of interest: \(\beta_1\) (DID effect).

**Validation:**
- Fisher test, multiple hypothesis correction, and attrition tests confirm robustness.

---

## 4. Results

### 4.1 Primary Outcome
- **Total Preventive Index:** Negative but insignificant effect (-0.037).  
- **Personal vs. Public Index:** Offset effect—Personal decreases, Public increases (both insignificant).  
- **Prior COVID exposure:** Reduces personal prevention but increases public preventive behaviors.

### 4.2 Heterogeneous Effects

#### 4.2.1 By Initial Preventive Index
- Low/medium baseline: Intervention increases total/public preventive index slightly.  
- High baseline: Intervention reduces preventive index (significant for Public Preventive Index).

#### 4.2.2 By Gender
- Females: Intervention significantly increases Public Preventive Index.  
- Males: Effect negative but insignificant.

#### 4.2.3 By National Background
- Local vs. international students show varying responsiveness; close relatives/friends contracting COVID raises Public Preventive Index more for locals.

---

## 5. Discussion

- Effectiveness of sequelae information is context-dependent, influenced by baseline behavior, gender, and social proximity to COVID cases.  
- Public preventive behaviors are more responsive than personal ones.  
- **Policy implication:** Targeted information campaigns could improve societal preventive behavior.

---

## 6. Conclusion

- Novel preventive and risk perception indexes allow quantifying behavior changes.  
- Heterogeneous effects suggest policymakers should tailor COVID information based on audience characteristics.  
- **Future work:** Larger samples, external validity checks, and longitudinal designs.
