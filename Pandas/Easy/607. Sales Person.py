


         # Approach 1. 

def sales_person(sales_person: pd.DataFrame, company: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    comp_orders = pd.merge(company, orders, how='left', on='com_id')
    all_tables = pd.merge(sales_person, comp_orders, how='left', on='sales_id', suffixes=('_sp', '_comp'))
    invalid_sp = all_tables[all_tables['name_comp'] == 'RED']
    valid_sp = all_tables[~all_tables['name_sp'].isin(invalid_sp['name_sp'])][['name_sp']].drop_duplicates()
    res = valid_sp.rename(columns={'name_sp': 'name'}) 

    return res
