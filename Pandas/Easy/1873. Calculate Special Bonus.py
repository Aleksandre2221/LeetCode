


         # Approach 1. 

def calculate_special_bonus(df: pd.DataFrame) -> pd.DataFrame:
    df['bonus'] = np.where((df['employee_id'] % 2 == 1) & (~df['name'].str.startswith('M')), df['salary'], 0)
    return df[['employee_id', 'bonus']].sort_values(by=['employee_id'])
    
