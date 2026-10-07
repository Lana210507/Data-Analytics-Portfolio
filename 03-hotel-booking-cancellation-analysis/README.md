# Hotel Booking Cancellation Analysis

## Project Overview

This project analyzes 119,390 hotel bookings to identify factors associated with booking cancellations and estimate cancellation risk using Logistic Regression.

The analysis focuses on booking characteristics, customer behavior, booking channels, hotel type, and lead-time patterns to understand where cancellation risk is concentrated.

## Business Problem

A high cancellation rate creates uncertainty in hotel demand forecasting and can affect room inventory planning, pricing, and overbooking decisions.

The analysis aims to answer:

- What factors are associated with hotel booking cancellations?
- Which booking segments have higher cancellation risk?
- Can cancellation likelihood be estimated using a predictive model?
- What actions could help reduce cancellation-related uncertainty?

## Objectives

1. Identify factors associated with hotel booking cancellations.
2. Predict the likelihood of booking cancellation.
3. Translate analytical findings into actionable business recommendations.

## Dataset

The dataset contains **119,390 hotel bookings across 32 variables**, including:

- Booking status
- Arrival dates
- Customer characteristics
- Stay duration
- Deposit type
- Distribution channel
- Market segment
- Cancellation history
- Average Daily Rate (ADR)

The analysis is based on hotel booking data covering **2015–2017**.

## Key Findings

### 1. High Overall Cancellation Rate

The overall cancellation rate is approximately **37%**, indicating substantial uncertainty in expected hotel demand.

### 2. Non-Refundable Bookings Show Extremely High Cancellation

Non-refundable bookings have a **99.4% cancellation rate**, making deposit type one of the strongest factors associated with cancellation.

### 3. Longer Lead Time Is Associated With Higher Cancellation

Cancellation rates increase with booking lead time, reaching **56.8% for bookings made 180+ days before arrival**.

### 4. Previous Cancellation History Is a Strong Risk Signal

Customers with exactly one previous cancellation have a **94.4% cancellation rate**, compared with **33.9%** for customers with no previous cancellations.

### 5. Cancellation Risk Varies Across Channels and Hotel Types

- TA/TO has a **41.0% cancellation rate** among major distribution channels.
- City Hotel has a **41.7% cancellation rate**, compared with **27.8%** for Resort Hotel.
- Groups have the highest market-segment cancellation rate at **61.1%**.

## Logistic Regression

A Logistic Regression model was developed to estimate cancellation likelihood and identify factors that remain associated with cancellation when modeled simultaneously.

### Model Performance

| Metric | Score |
|---|---:|
| Accuracy | 79.9% |
| Precision | 86.0% |
| Recall | 55.0% |
| F1-Score | 67.0% |
| ROC-AUC | 84.1% |

### Top Factors

| Factor | Odds Ratio |
|---|---:|
| Non-Refund Deposit | 140.61 |
| Previous Cancellations | 9.88 |
| Transient Customer | 2.13 |
| Lead Time | 1.59 |

An odds ratio above 1 indicates higher odds of cancellation, holding the other modeled variables constant.

## Business Recommendations

### 1. Implement a 90-Day Lead-Time Monitoring Rule

Flag bookings made 90+ days before arrival for additional confirmation monitoring.

**Expected impact:** Improve demand forecasting and reduce occupancy uncertainty.

### 2. Review TA/TO Partner Booking & Confirmation Processes

Monitor partner-level cancellation performance and investigate partners with deteriorating cancellation outcomes.

**Expected impact:** Improve occupancy predictability and reduce cancellation-related uncertainty.

### 3. Develop a Cancellation-Risk Flag System

Use the Logistic Regression model to classify bookings according to cancellation risk and prioritize high-risk bookings for monitoring.

**Expected impact:** Focus operational resources on higher-risk bookings and improve demand forecasting.

## Tools & Technologies

- Python
- Pandas
- Scikit-learn
- Matplotlib
- Seaborn
- SQL
- Tableau

## Project Workflow

**Problem Understanding → Data Cleaning → Exploratory Data Analysis → Logistic Regression → Visualization → Business Recommendations**

## Limitations

The dataset does not contain actual revenue figures, operating costs, profitability data, or explicit reasons for cancellation. Therefore, this analysis identifies **associations with cancellation rather than direct causal drivers or actual revenue loss**.

## Dashboard

[View the Tableau Dashboard](https://public.tableau.com/app/profile/muhammad.maulana4541/viz/ALOHA_17900592702410/Dashboard1)

## Data Source

[Hotel Booking Demand Dataset](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
