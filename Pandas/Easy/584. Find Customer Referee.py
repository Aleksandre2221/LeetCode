


         # Approach 1. 

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    res = customer[(customer['referee_id'].isna()) | (customer['referee_id'] != 2)][['name']]

    return res
