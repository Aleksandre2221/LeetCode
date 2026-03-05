


         # Approach 1. 

def count_rich_customers(store: pd.DataFrame) -> pd.DataFrame:
    rich_customers = store[store['amount'] > 500]
    rich_cnt = rich_customers['customer_id'].nunique()
    res = pd.DataFrame({'rich_count': [rich_cnt]})
    
    return res
