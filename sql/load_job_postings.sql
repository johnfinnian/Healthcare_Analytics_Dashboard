
\copy job_postings_staging FROM 'C:\Users\chimc\Documents\Healthcare_Jobs_Project\postings.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy companies_staging FROM 'C:\Users\chimc\Documents\Healthcare_Jobs_Project\companies\companies.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');



\copy company_industries FROM 'C:\Users\chimc\Documents\Healthcare_Jobs_Project\companies\company_industries.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')
\copy company_specialities FROM 'C:\Users\chimc\Documents\Healthcare_Jobs_Project\companies\company_specialities.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')
\copy employee_counts FROM 'C:\Users\chimc\Documents\Healthcare_Jobs_Project\companies\employee_counts.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')

