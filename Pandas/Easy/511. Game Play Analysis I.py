


         # Approach 1. 

def game_analysis(df: pd.DataFrame) -> pd.DataFrame:
    df_sorted = df.sort_values(by=['player_id', 'event_date'])
    df_first = df_sorted.drop_duplicates(subset=['player_id'])
    df_renamed = df_first.rename(columns={'event_date': 'first_login'})

    return df_renamed[['player_id', 'first_login']]


        # Approach 2. 

  def game_analysis(df: pd.DataFrame) -> pd.DataFrame:

    return (
        df.sort_values(['player_id', 'event_date'])
          .drop_duplicates('player_id')
          .rename(columns={'event_date': 'first_login'})
          [['player_id', 'first_login']]
    )
