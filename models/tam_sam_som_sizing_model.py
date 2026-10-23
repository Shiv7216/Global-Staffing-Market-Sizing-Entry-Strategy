import pandas as pd

WEIGHTS = {
    "regulatory_ease_score": 0.25,
    "wage_margin_norm": 0.20,
    "it_demand_index": 0.20,
    "healthcare_demand_index": 0.20,
    "competitive_density_score": 0.15,
}

def run_market_sizing_and_scorecard(csv_path: str = "data/global_staffing_market_data.csv") -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df["tam_usd_bn"] = (
        df["skilled_labor_deficit_k"] * 1000.0
        * df["avg_annual_bill_rate_usd"]
        * (df["agency_penetration_pct"] / 100.0)
    ) / 1e9
    df["sam_usd_bn"] = df["tam_usd_bn"] * (df["gross_margin_spread_pct"] / 100.0) * 0.185
    df["som_yr3_usd_m"] = df["sam_usd_bn"] * 1000.0 * 0.08

    df["wage_margin_norm"] = (df["gross_margin_spread_pct"] / df["gross_margin_spread_pct"].max()) * 10.0
    df["composite_score"] = (
        df["regulatory_ease_score"] * WEIGHTS["regulatory_ease_score"]
        + df["wage_margin_norm"] * WEIGHTS["wage_margin_norm"]
        + df["it_demand_index"] * WEIGHTS["it_demand_index"]
        + df["healthcare_demand_index"] * WEIGHTS["healthcare_demand_index"]
        + df["competitive_density_score"] * WEIGHTS["competitive_density_score"]
    ).round(2)

    return df.sort_values(by="composite_score", ascending=False)

if __name__ == "__main__":
    results = run_market_sizing_and_scorecard()
    print(f"Total Addressable Market (TAM): ${results['tam_usd_bn'].sum():.2f}B")
    print(f"Serviceable Available Market (SAM): ${results['sam_usd_bn'].sum():.2f}B")
    print(results[["country", "region", "tam_usd_bn", "sam_usd_bn", "composite_score"]].to_string(index=False))

