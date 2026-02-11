


        # Approach 1. 

def count_unique_subjects(df: pd.DataFrame) -> pd.DataFrame:
    return df.groupby('teacher_id').agg(cnt=('subject_id', 'nunique')).reset_index()
