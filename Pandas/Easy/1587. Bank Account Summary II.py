


         # Appeoach 1. 

def account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    merged = pd.merge(users, transactions, how='inner', on='account')
    balance = merged.groupby(['account', 'name'])['amount'].sum().reset_index(name='balance')
    valid_users = balance[balance['balance'] > 10000][['name', 'balance']]

    return valid_users
