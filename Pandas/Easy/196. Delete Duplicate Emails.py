


         # Approach 1.

def delete_duplicate_emails(person: pd.DataFrame) -> None:
    person.drop_duplicates(subset='email', inplace=True)
