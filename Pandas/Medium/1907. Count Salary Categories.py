


         # Approach 1. 

def count_salary_categories(df: pd.DataFrame) -> pd.DataFrame:
    df['Low Salary'] = df['income'] < 20000
    df['Average Salary'] = (df['income'] >= 20000) & (df['income'] <= 50000)
    df['High Salary'] = df['income'] > 50000

    df_melted = df.melt(
        id_vars=['account_id', 'income'],         
        value_vars=['Low Salary', 'Average Salary', 'High Salary'],  
        var_name='category',          
        value_name='flag'                    
    )

    df_melted = df_melted.groupby('category').agg(accounts_count=('flag', 'sum')).reset_index()
    return df_melted
