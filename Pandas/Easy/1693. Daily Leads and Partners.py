


         # Approach 1. 

def daily_leads_and_partners(df: pd.DataFrame) -> pd.DataFrame:

    return (
            df
            .groupby(['date_id', 'make_name'])
            .agg(
                unique_leads=('lead_id', 'nunique'), 
                unique_partners=('partner_id', 'nunique')
            )
            .reset_index()
        )       
