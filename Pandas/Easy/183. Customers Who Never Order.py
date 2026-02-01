


         # Approach 1. Using - pd.merge -- 

def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    res = pd.merge(customers, orders, left_on='id', right_on='customerId', how='left')
    return res[res['customerId'].isna()][['name']].rename(columns={'name': 'Customers'})


         # Approach 2. Using - ~isin() condition -- 

  def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    res = customers[~customers['id'].isin(orders['customerId'])]
    return res[['name']].rename(columns={'name': 'Customers'})
