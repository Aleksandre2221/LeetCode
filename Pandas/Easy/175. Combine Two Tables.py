


         # Approach 1. 

def combine_two_tables(person: pd.DataFrame, address: pd.DataFrame) -> pd.DataFrame:
    merged = pd.merge(person, address, how='left', on='personId')

    return merged[['firstName', 'lastName', 'city', 'state']]
