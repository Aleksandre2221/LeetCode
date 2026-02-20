


         # Approach 1. 

def employee_bonus(employee: pd.DataFrame, bonus: pd.DataFrame) -> pd.DataFrame:
    merged = pd.merge(employee, bonus, how='left', on='empId')
    res = merged[(merged['bonus'] < 1000) | (merged['bonus'].isna())][['name', 'bonus']]

    return res
