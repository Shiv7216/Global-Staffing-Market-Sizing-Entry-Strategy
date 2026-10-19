-- Global Staffing Market Sizing & Corridor Prioritization (PostgreSQL)

-- 1. Regional TAM & SAM Breakdown (Top-Down & Bottom-Up Reconciliation)
WITH country_valuations AS (
    SELECT
        country,
        region,
        skilled_labor_deficit_k,
        avg_annual_bill_rate_usd,
        agency_penetration_pct,
        gross_margin_spread_pct,
        ROUND((skilled_labor_deficit_k * 1000.0 * avg_annual_bill_rate_usd * (agency_penetration_pct / 100.0)) / 1e9, 2) AS addressable_tam_usd_bn,
        ROUND((skilled_labor_deficit_k * 1000.0 * avg_annual_bill_rate_usd * (agency_penetration_pct / 100.0) * (gross_margin_spread_pct / 100.0) * 0.185) / 1e9, 3) AS serviceable_sam_usd_bn
    FROM global_staffing_market
)
SELECT
    region,
    COUNT(country) AS evaluated_markets,
    SUM(skilled_labor_deficit_k) AS total_deficit_thousands,
    ROUND(SUM(addressable_tam_usd_bn), 2) AS regional_tam_usd_bn,
    ROUND(SUM(serviceable_sam_usd_bn), 3) AS regional_sam_usd_bn
FROM country_valuations
GROUP BY region
ORDER BY regional_sam_usd_bn DESC;

-- 2. Five-Factor Weighted Market Entry Scorecard
SELECT
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
ORDER BY composite_entry_score DESC;

