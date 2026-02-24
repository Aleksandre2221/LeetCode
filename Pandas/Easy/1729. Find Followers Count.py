


         # Approach 1. 

def count_followers(followers: pd.DataFrame) -> pd.DataFrame:
    foll_cnt = followers.groupby('user_id').agg(followers_count=('user_id', 'count')).reset_index()
    ordered_table = foll_cnt.sort_values(by='user_id')

    return ordered_table 
