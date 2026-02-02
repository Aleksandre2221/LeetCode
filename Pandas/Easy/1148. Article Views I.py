


         # Approach 1. 

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    filtered_views = views[views['author_id'] == views['viewer_id']]
    unique_views = filtred_views[['viewer_id']].rename(columns={'viewer_id': 'id'}).drop_duplicates()
    sorted_views = unique_views.sort_values(by='id')
  
    return sorted_views
