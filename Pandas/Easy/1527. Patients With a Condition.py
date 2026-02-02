


         # Appeoach 1. 

def find_patients(df: pd.DataFrame) -> pd.DataFrame:
    cond1 = df['conditions'].str.startswith('DIAB1')
    cond2 = df['conditions'].str.contains(' DIAB1')
    return df[cond1 | cond2][['patient_id', 'patient_name', 'conditions']]
