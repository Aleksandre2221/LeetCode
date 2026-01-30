


         # Approach 1. 

def big_countries(df: pd.DataFrame) -> pd.DataFrame:
    return df[(df['area'] >= 3000000)|(df['population'] >= 25000000)][['name', 'population', 'area']]



         # Approach 2. Using - df.query() -- 

def big_countries(df: pd.DataFrame) -> pd.DataFrame:
    return df.query('area >= 3000000 or population >= 25000000')[['name', 'population', 'area']]

    
