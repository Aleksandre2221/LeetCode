


         # Approach 1. 

def duplicate_emails(df: pd.DataFrame) -> pd.DataFrame:

    email_cnt = df['email'].value_counts().reset_index()
    duplicated = email_cnt[email_cnt['count'] > 1][['Email']]
    return duplicated



        # Approach 2. 

def duplicate_emails(df: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame({'email': df.loc[df['email'].duplicated(keep=False), 'email'].unique()})
