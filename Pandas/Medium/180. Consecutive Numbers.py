


         # Approach 1. 

def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    sorted_logs = logs.sort_values(by='id')
    mask = (
        (sorted_logs['num'] == sorted_logs['num'].shift(1)) &
        (sorted_logs['num'] == sorted_logs['num'].shift(2))
    )
    
    result = sorted_logs.loc[mask, ['num']].drop_duplicates()
    result.columns = ['ConsecutiveNums']

    return result
