


         # Approach 1. 

def find_classes(df: pd.DataFrame) -> pd.DataFrame:
    df = df['class'].value_counts().reset_index()

    return df[df['count'] >= 5][['class']]
