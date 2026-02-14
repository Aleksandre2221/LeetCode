


         # Approach 1. 

def replace_employee_id(employees: pd.DataFrame, employee_uni: pd.DataFrame) -> pd.DataFrame:
    df = pd.merge(employees, employee_uni, how='left', on='id')

    return df[['unique_id', 'name']]
