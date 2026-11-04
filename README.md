# Global Staffing Market Sizing & GTM Entry Strategy (TAM / SAM / SOM)

An end-to-end quantitative market sizing, corridor valuation, and Go-To-Market (GTM) entry strategy evaluating cross-border staffing opportunities across **North America, Europe, and APAC**. Using a dual **Top-Down macroeconomic labor-deficit model** and **Bottom-Up bill-rate and agency-penetration reconciliation**, this project sizes a **$42.4B Total Addressable Market (TAM)**, isolates a **$1.82B Serviceable Available Market (SAM)**, and ranks 11 target countries across a 5-factor weighted entry scorecard.

---

## Executive Summary & Market Sizing Funnel

| Valuation Tier | Market Scope & Filtering Methodology | Estimated Value |
| :--- | :--- | :---: |
| **Total Addressable Market (TAM)** | Aggregate cross-border skilled labor deficit across North America, Europe & APAC multiplied by regional annual bill rates and staffing agency penetration | **$42.40B** |
| **Serviceable Available Market (SAM)** | Mid-market enterprise IT/Engineering & Allied-Healthcare segments accessible via specialized cross-border placement & EOR fulfillment | **$1.82B** |
| **Serviceable Obtainable Market (SOM)** | 36-month capture target focused on Tier-1 US & UK corridors (8.0% serviceable corridor share) | **$145.60M** |

### Core Strategic Recommendations
* **Tier-1 Priority Corridors (US & UK):** The **United States (Score: 8.71 / 10)** and **United Kingdom (Score: 8.51 / 10)** account for **63.8% of total serviceable gross margin pool ($1.16B SAM)**, driven by acute structural deficits in software engineering and allied-healthcare personnel alongside high agency adoption (`14.8%-16.2%`).
* **Vertical Specialization Wedge:** Bypassing low-margin commoditized general staffing (`<12%` spread) to focus exclusively on **IT/Data Engineering** and **Allied Healthcare** captures **22.8%-24.5% gross bill-to-pay margins**.
* **Wave-2 Expansion (Germany, Australia, Ireland):** Enter Germany and Australia in Months 7-12 via Employer-of-Record (EOR) partnerships to mitigate local licensing friction while capturing high bill-rate engineering demand.

---

## 1. Five-Factor Weighted Market Entry Scorecard

Each target country was evaluated across five weighted dimensions: **Regulatory & Visa Ease (25%)**, **Gross Wage Margin Spread (20%)**, **IT & Tech Talent Deficit (20%)**, **Allied-Healthcare Demand (20%)**, and **Competitive Whitespace (15%)**.

| Rank | Target Market | Region | Est. TAM ($B) | Serviceable SAM ($B) | Gross Margin Spread | Regulatory Ease (1-10) | IT / Healthcare Demand | Composite Entry Score |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **1** | **United States** | North America | $20.70B | **$0.94B** | 24.5% | 8.4 | 9.5 / 9.3 | **8.71 / 10** |
| **2** | **United Kingdom** | Europe | $6.08B | **$0.26B** | 22.8% | 8.6 | 8.9 / 9.1 | **8.51 / 10** |
| **3** | **Ireland** | Europe | $1.54B | **$0.07B** | 23.1% | 8.5 | 8.8 / 7.9 | **8.27 / 10** |
| **4** | **UAE** | APAC / MEA | $2.45B | **$0.12B** | 26.0% | 8.8 | 7.8 / 8.2 | **8.26 / 10** |
| **5** | **Australia** | APAC | $3.19B | **$0.13B** | 21.8% | 7.9 | 8.0 / 8.6 | **8.01 / 10** |
| **6** | **Canada** | North America | $3.14B | **$0.12B** | 20.5% | 8.2 | 8.1 / 8.5 | **7.92 / 10** |
| **7** | **Germany** | Europe | $5.78B | **$0.22B** | 21.0% | 6.8 | 8.7 / 8.8 | **7.83 / 10** |


---

## 2. Quantitative Valuation Methodology & SQL Analytics

### 2.1 Top-Down & Bottom-Up Sizing Formula
<pre><code>Addressable Market (TAM) = Skilled_Labor_Deficit * Avg_Annual_Bill_Rate * Agency_Penetration_Rate
Serviceable Market (SAM) = TAM * Gross_Margin_Spread * Mid_Market_Segment_Share (18.5%)
Obtainable Market (SOM)  = SAM * 3-Year_Target_Capture_Rate (8.0%)</code></pre>

### 2.2 Corridor Prioritization & Composite Ranking Query (`sql/market_corridor_analysis.sql`)
<pre><code>SELECT
    country,
    region,
    gross_margin_spread_pct,
    regulatory_ease_score,
    it_demand_index,
    healthcare_demand_index,
    ROUND(
        (regulatory_ease_score * 0.25) +
        ((gross_margin_spread_pct / 3.0) * 0.20) +
        (it_demand_index * 0.20) +
        (healthcare_demand_index * 0.20) +
        (competitive_density_score * 0.15), 2
    ) AS composite_entry_score,
    DENSE_RANK() OVER (
        ORDER BY (
            (regulatory_ease_score * 0.25) +
            ((gross_margin_spread_pct / 3.0) * 0.20) +
            (it_demand_index * 0.20) +
            (healthcare_demand_index * 0.20) +
            (competitive_density_score * 0.15)
        ) DESC
    ) AS priority_rank
FROM global_staffing_market
ORDER BY composite_entry_score DESC;</code></pre>

---

## 3. Phased Go-To-Market (GTM) Expansion Roadmap

* **Phase 1 — US & UK Anchor Corridors (Months 1-6):** Target mid-market MSP/VMS ecosystems and regional healthcare networks in the US and UK. Focus on high-margin contract-to-hire IT engineering roles and credentialed allied-healthcare placements (`$95K+` annualized bill rate).
* **Phase 2 — EU & APAC Bilateral Corridors (Months 7-12):** Expand into Ireland, Australia, and Germany utilizing Employer-of-Record (EOR) compliance partners to streamline work-permit sponsorship and reduce onboarding lead times by **35%**.
* **Phase 3 — Enterprise Account Penetration (Months 13-24):** Transition transactional staffing accounts into multi-year managed capacity agreements to capture **$145.6M in cumulative SOM**.

---

## Repository Structure

<pre><code>data/
  global_staffing_market_data.csv    Cross-border labor deficit, bill rate, and margin dataset
models/
  tam_sam_som_sizing_model.py        Python TAM/SAM/SOM valuation & weighted scorecard model
sql/
  market_corridor_analysis.sql       PostgreSQL regional sizing and DENSE_RANK() scorecard queries
docs/
  gtm_entry_roadmap.md               Executive Go-To-Market phased implementation brief
README.md                            Executive case study, scorecard tables, and methodology</code></pre>

