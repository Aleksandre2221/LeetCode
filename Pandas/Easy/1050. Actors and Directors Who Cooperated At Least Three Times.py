


         # Approach 1. 

def actors_and_directors(df: pd.DataFrame) -> pd.DataFrame:
    coop_cnt = df.groupby(['actor_id', 'director_id']).agg(cnt=('timestamp', 'count')).reset_index()

    return coop_cnt[coop_cnt['cnt'] >= 3][['actor_id', 'director_id']]
