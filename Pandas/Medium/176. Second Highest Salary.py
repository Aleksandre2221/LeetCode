


         # Approach 1. 

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    res = employee['salary'].drop_duplicates().sort_values(ascending=False).reset_index(drop=True)

    if len(res) > 1:
        return pd.DataFrame({'SecondHighestSalary': [res[1]]})
    else:
        return pd.DataFrame({'SecondHighestSalary': [None]}) 


        # Approach 2. 

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    res = employee['salary'].drop_duplicates().sort_values(ascending=False).reset_index(drop=True)
    second = res[1] if len(res) > 1 else None

    return pd.DataFrame({'SecondHighestSalary': [second]})
