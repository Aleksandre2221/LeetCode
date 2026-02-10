


         # Approach 1. 

def total_time(df: pd.DataFrame) -> pd.DataFrame:
    df['total_time'] = df['out_time'] - df['in_time']
    res = df.groupby(['event_day', 'emp_id'], as_index=False)['total_time'].sum()
    res = res.rename(columns={'event_day': 'day'})

    return res

