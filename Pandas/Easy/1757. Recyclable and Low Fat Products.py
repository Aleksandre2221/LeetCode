


         # Approach 1. 

def find_products(df: pd.DataFrame) -> pd.DataFrame:
    return df[(df['low_fats'] == 'Y') & (df['recyclable'] == 'Y')][['product_id']]


         # Approach 2. Using - df.query() -- 
  def find_products(df: pd.DataFrame) -> pd.DataFrame:
    return df.query("low_fats == 'Y' and recyclable == 'Y'")[['product_id']]
