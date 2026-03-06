


         # Approach 1. 

def food_delivery(delivery: pd.DataFrame) -> pd.DataFrame:
    immediate_cnt = (delivery['order_date'] == delivery['customer_pref_delivery_date']).sum()
    res = round(immediate_cnt * 100 / delivery.shape[0], 2)

    return pd.DataFrame({'immediate_percentage': [res]}) 
