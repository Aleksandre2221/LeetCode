


         # Approach 1. 

def largest_orders(df: pd.DataFrame) -> pd.DataFrame:
    counts = df['customer_number'].value_counts().reset_index() 
    counts.columns = ['customer_number', 'total_orders']

    return counts[counts['total_orders'] == counts['total_orders'].max()][['customer_number']]
