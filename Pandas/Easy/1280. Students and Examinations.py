


         # Approach 1. 

def students_and_examinations(students: pd.DataFrame, subjects: pd.DataFrame, examinations: pd.DataFrame) -> pd.DataFrame:

    all_subs = pd.merge(students, subjects, how='cross')
    renamed_exam_subj = examinations.rename(columns={'subject_name': 'subject_name_exam'})
    all_exam_subs = pd.merge(all_subs, renamed_exam_subj, how='left', left_on=['student_id', 'subject_name'], right_on=['student_id', 'subject_name_exam'])
    attends_cnt = all_exam_subs.groupby(['student_id', 'subject_name']).agg(attended_exams =('subject_name_exam', 'count')).reset_index()
    students_name = pd.merge(attends_cnt, students, how='inner', on='student_id')
    sorted_columns = students_name[['student_id', 'student_name', 'subject_name', 'attended_exams']].sort_values(by=['student_id', 'student_name'])

    return sorted_columns
