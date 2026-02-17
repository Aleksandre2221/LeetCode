


        # Approach 1. 

def project_employees_i(project: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:
    merged = pd.merge(project, employee, how='inner', on=['employee_id'])
    avg_exp = merged.groupby('project_id')['experience_years'].mean().round(2).reset_index(name='average_years')

    return avg_exp


        # Approach 2. 

def project_employees_i(project: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:

      return (project
                .merge(employee)
                .groupby('project_id')['experience_years']
                .mean()
                .round(2)
                .reset_index(name='average_years')
             )
