# TokoBli Campaign Performance & A/B Testing Analysis

## Project Overview

This project evaluates the performance of three TokoBli e-commerce promotional campaigns — 10/10, 11/11, and 12/12 — and analyzes an A/B test comparing two product detail page designs.

The analysis focuses on campaign performance, promotional efficiency, customer and transaction volume, category performance, and whether the new product detail page generated a higher average transaction value.

---

## Business Questions

The analysis aims to answer three key questions:

1. **Campaign Performance**  
   Which campaign delivered the strongest combination of revenue, customers, transactions, and units sold?

2. **Campaign Efficiency**  
   Which campaign generated the most revenue relative to discount spending?

3. **Product Experimentation**  
   Did the new product detail page significantly increase average transaction value compared with the existing page?

---

## Dataset

The dataset contains e-commerce transaction data covering three promotional campaign periods:

- 10/10
- 11/11
- 12/12

The analysis also includes data from an A/B test comparing:

- **Group A:** Current product detail page
- **Group B:** New product detail page

After data preparation, the analysis used 10,142 transaction records.

---

## Data Preparation

The dataset was reviewed and cleaned before analysis.

Key preparation steps included:

- Handling missing values for price, quantity, and discount
- Removing 5 duplicate records
- Removing shipping cost because all values were 0
- Removing irrelevant columns that were not required for the analysis
- Standardizing currency and numerical formatting
- Identifying revenue outliers using the 1.5 × IQR method

### Outlier Detection

The analysis identified 12 revenue records above the upper IQR fence.

- Q1: Rp2,241,000
- Q3: Rp6,987,500
- IQR: Rp4,746,500
- Upper Fence: Rp14,107,250
- Outliers identified: 12

---

## Analysis

The project covers:

- Descriptive statistics
- Campaign performance comparison
- Revenue and discount analysis
- Revenue-to-discount ratio
- Customer and transaction analysis
- Category performance
- Campaign-specific category analysis
- A/B testing
- Business recommendations

---

## Key Findings

### 1. 11/11 was strongest for scale

The 11/11 campaign generated:

- **Rp16.62B** in revenue
- **1,567 customers**

This makes 11/11 the strongest campaign for revenue scale and customer acquisition among the three campaigns.

### 2. 12/12 was strongest for transaction volume

The 12/12 campaign generated:

- **3,414 transactions**
- **4,485 units sold**

This makes 12/12 the strongest campaign for transaction and product volume.

### 3. 12/12 had the strongest promotional efficiency

The revenue-to-discount ratios were:

| Campaign | Revenue-to-Discount Ratio |
|---|---:|
| 10/10 | 53.83 |
| 11/11 | 54.92 |
| 12/12 | 58.54 |

12/12 achieved the highest ratio at **58.54**.

This metric is used as a promotional-efficiency proxy and should not be interpreted as profit margin or ROI.

### 4. Men's Fashion was the strongest category

Men's Fashion led the major sales metrics across the campaigns, including:

- Customer count
- Product volume
- Transaction count
- Revenue

It also had the lowest discount rate overall.

### 5. Category efficiency varied by campaign

The analysis identified the following campaign-specific category opportunities:

| Campaign | Category | Revenue-to-Discount Ratio |
|---|---|---:|
| 10/10 | School & Education | 104.89 |
| 11/11 | Men's Fashion | 139.3 |
| 12/12 | Books | 138.8 |

These patterns suggest potential opportunities for category-specific promotional strategies and further testing.

---

## A/B Testing

The project evaluated whether a new product detail page affected average transaction value.

### Hypotheses

**H₀:** μA = μB

**H₁:** μA ≠ μB

Significance level:

**α = 0.05**

### Results

| Group | Product Page | Average Transaction Value |
|---|---|---:|
| A | Current | Rp746,103 |
| B | New | Rp830,460 |

Group B showed an approximately **11.3% higher average transaction value** than Group A.

The two-sample t-test produced:

**p < 0.001**

Decision:

**Reject H₀**

### Conclusion

The analysis provides statistical evidence that average transaction value differed significantly between the two product page groups, with Group B showing the higher average transaction value.

The result specifically evaluates transaction value and should not be interpreted as evidence that the new page improves every business metric.

---

## Business Recommendations

### 1. Prioritize 11/11 for scale

Use campaign strategies similar to 11/11 when the primary objective is revenue scale and customer acquisition.

### 2. Leverage 12/12 for efficiency and volume

Study the promotional mechanics used during 12/12 for future campaigns because it achieved the strongest transaction volume and revenue-to-discount ratio.

### 3. Prioritize Men's Fashion

Maintain stronger promotional focus on Men's Fashion based on its strong performance across major sales metrics.

### 4. Test category-specific promotions

Use the observed category patterns as hypotheses for future campaign testing rather than assuming that historical performance guarantees future results.

### 5. Recommend rollout of the new product page with monitoring

The A/B test provides statistical evidence of higher average transaction value for Group B.

After rollout, monitor additional business metrics such as conversion rate and downstream revenue performance where available.

---

## Limitations

- The dataset does not provide detailed campaign cost or profit information.
- Revenue-to-discount ratio is a promotional-efficiency proxy, not profitability or ROI.
- Campaign analysis covers only three promotional periods.
- The A/B test focuses on average transaction value rather than the complete conversion funnel.
- The dataset is an educational/project dataset and should not be interpreted as representing actual TokoBli business performance.

---

## Next Steps

Potential follow-up analysis could include:

- Conversion rate analysis
- Revenue per customer
- New vs. returning customer segmentation
- Campaign ROI analysis if cost data becomes available
- Post-launch monitoring of the new product page
- Additional controlled experiments

---

## Deliverables

### Presentation

[View the full project presentation](./TokoBli_Campaign_Performance_Analysis.pdf)

---

## Project Structure

```text
project-01-tokobli-campaign-analysis/
│
├── README.md
│
└── TokoBli_Campaign_Performance_Analysis.pdf
