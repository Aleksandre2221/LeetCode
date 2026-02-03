


         # Approach 1. 
def nth_highest_salary(df, n):
    unique_salaries = df['salary'].drop_duplicates().sort_values(ascending=False).reset_index(drop=True)
    
    if n <= 0 or n > len(unique_salaries):
        nth_salary = np.nan
    else:
        nth_salary = unique_salaries.iloc[n-1]
    
    return pd.DataFrame({f'getNthHighestSalary({n})': [nth_salary]})
