


         # Approach 1. 

def department_highest_salary(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    dep_salary = pd.merge(employee, department, left_on=['departmentId'], right_on=['id'], how='inner', suffixes=('_emp', '_dep'))
    max_dep_salary = dep_salary.groupby(['departmentId'])['salary'].max().reset_index()
    max_emp_dep_salary = pd.merge(dep_salary, max_dep_salary, on=['departmentId', 'salary'], how='inner')
    max_emp_dep_salary = max_emp_dep_salary.rename(columns={'name_dep': 'Department', 'name_emp': 'Employee'})

    return max_emp_dep_salary[['Department', 'Employee', 'salary']]

