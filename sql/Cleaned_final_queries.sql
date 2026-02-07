CREATE TABLE job_postings_staging (    --- staging table with all columns as TEXT
    job_id TEXT PRIMARY KEY,
    company_id TEXT,
    title TEXT,
    description TEXT,
    max_salary TEXT,
    med_salary TEXT,
    min_salary TEXT,
    pay_period TEXT,
    location TEXT,
    formatted_work_type TEXT,
    applies TEXT,
    views TEXT,
    original_listed_time TEXT,
    listed_time TEXT,
    closed_time TEXT,
    remote_allowed TEXT,
    work_type TEXT,
    currency TEXT,
    compensation_type TEXT,
    posting_domain TEXT,
    sponsored TEXT,
    normalized_salary TEXT,
    zip_code TEXT,
    fips TEXT);



CREATE TABLE job_postings (  -- final table with appropriate data types
    job_id BIGINT PRIMARY KEY,
    company_id BIGINT,
    title TEXT,
    description TEXT,
    max_salary NUMERIC,
    med_salary NUMERIC,
    min_salary NUMERIC,
    pay_period TEXT,
    location TEXT,
    formatted_work_type TEXT,
    applies INTEGER,
    views INTEGER,
    original_listed_time TIMESTAMP,
    listed_time TIMESTAMP,
    closed_time TIMESTAMP,
    remote_allowed BOOLEAN,
    work_type TEXT,
    currency TEXT,
    compensation_type TEXT,
    posting_domain TEXT,
    sponsored BOOLEAN,
    normalized_salary NUMERIC,
    zip_code TEXT,
    fips TEXT
);

INSERT INTO job_postings (  -- inserting data with type casting and cleaning
    job_id,
    company_id,
    title,
    description,
    max_salary,
    med_salary,
    min_salary,
    pay_period,
    location,
    formatted_work_type,
    applies,
    views,
    original_listed_time,
    listed_time,
    closed_time,
    remote_allowed,
    work_type,
    currency,
    compensation_type,
    posting_domain,
    sponsored,
    normalized_salary,
    zip_code,
    fips
)
SELECT DISTINCT ON (job_id) 
    job_id::BIGINT,
    FLOOR(NULLIF(company_id, '')::NUMERIC)::BIGINT,
    title,
    description,
    max_salary::NUMERIC,
    med_salary::NUMERIC,
    min_salary::NUMERIC,
    pay_period,
    location,
    formatted_work_type,
    NULLIF(applies, '')::NUMERIC::INTEGER,
    NULLIF(views, '')::NUMERIC::INTEGER,
    TO_TIMESTAMP(NULLIF(original_listed_time,'')::NUMERIC / 1000),
    TO_TIMESTAMP(NULLIF(listed_time,'')::NUMERIC / 1000),
    TO_TIMESTAMP(NULLIF(closed_time,'')::NUMERIC / 1000),
    CASE
        WHEN NULLIF(remote_allowed, '')::NUMERIC = 1 THEN TRUE
        WHEN NULLIF(remote_allowed, '')::NUMERIC = 0 THEN FALSE
        ELSE NULL
    END AS remote_allowed,
    work_type,
    currency,
    compensation_type,
    posting_domain,
     CASE
        WHEN NULLIF(sponsored, '')::NUMERIC = 1 THEN TRUE
        WHEN NULLIF(sponsored, '')::NUMERIC = 0 THEN FALSE
        ELSE NULL
    END AS sponsored,
    normalized_salary::NUMERIC,
    zip_code,
    fips
FROM job_postings_staging
ORDER BY job_id, listed_time DESC;

--- Same method was used to insert raw data into other tables.



CREATE TABLE clinical_role (
    role_name TEXT NOT NULL,
    keyword TEXT PRIMARY KEY,
    priority INT NOT NULL
); 

INSERT INTO clinical_role (role_name, keyword, priority) VALUES
('Physician', 'physician', 1),

('Physician Assistant', 'physician assistant', 2),

('Nurse', 'nurse practitioner', 0),
('Nurse', 'registered nurse', 1),
('Nurse', 'nurse', 2),

('Physiotherapist', 'physical therapist', 1),
('Physiotherapist', 'physiotherapist', 1),

('Speech Pathologist', 'speech language', 1),
('Speech Pathologist', 'speech pathologist', 1),

('Dietitian', 'dietitian', 1),
('Dietitian', 'nutritionist', 1),

('Chiropractor', 'chiropractor', 1),

('Audiologist', 'audiologist', 1),

('Genetic Counselor', 'genetic counselor', 1),

('Psychologist', 'psychologist', 1),
('Psychotherapist', 'psychotherapist', 1),

('Optometrist', 'optometrist', 1),
('Dentist', 'dentist', 1),

('Lab Scientist', 'lab scientist', 2),
('Lab Scientist', 'laboratory scientist', 1),

('Optometric Assistant', 'optometric assistant', 1),
('Medical Assistant', 'medical assistant', 2),
('Medical Technician', 'medical technician', 2),
('Medical Technologist', 'medical technologist', 2),

('Public Health', 'public health', 1),
('Public Health', 'epidemiologist', 1),

('Pharmacist', 'pharmacist', 1),

('Paramedic', 'paramedic', 1),

('Veterinarian', 'veterinarian', 1),
('Veterinary Technician', 'veterinary technician', 1);


CREATE TABLE clinical_specialty (
    specialty_id SERIAL PRIMARY KEY,
    specialty_name TEXT NOT NULL,
    keyword TEXT NOT NULL, 
    applies_to_role TEXT NULL,
    priority INT NOT NULL DEFAULT 1
);

INSERT INTO clinical_specialty (specialty_name, keyword, applies_to_role, priority)
VALUES
-- Physician specialties
('Neurology', 'neurologist', 'Physician', 1),
('Neurology', 'neurology', 'Physician', 2),

('General Medicine', 'medical doctor', 'Physician', 1),
('General Medicine', 'medical officer', 'Physician', 1),

('Admin', 'medical director', 'Physician', 1),
('Admin', 'director of medical', 'Physician', 2),

('Radiology', 'radiologist', 'Physician', 1),

('Cardiology', 'cardiologist', 'Physician', 1),
('Cardiology', 'cardiology', 'Physician', 2),

('Oncology', 'oncologist', 'Physician', 1),
('Oncology', 'oncology', 'Physician', 2),

('Dermatology', 'dermatologist', 'Physician', 1),
('Dermatology', 'dermatology', 'Physician', 2),

('Anesthesiology', 'anesthesiologist', 'Physician', 1),
('Anesthesiology', 'anesthesiology', 'Physician', 2),

('Surgery', 'surgery', 'Physician', 1),

('Pediatrics', 'pediatrician', 'Physician', 1),

('Ophthalmology', 'ophthalmologist', 'Physician', 1),
('Ophthalmology', 'ophthalmology', 'Physician', 2),

('Psychiatry', 'psychiatrist', 'Physician', 1),
('Psychiatry', 'psychiatry', 'Physician', 2),

('OB/GYN', 'gynecologist', 'Physician', 1),
('OB/GYN', 'gynecology', 'Physician', 1),
('OB/GYN', 'ob/gyn', 'Physician', 1),
('OB/GYN', 'ob gyn', 'Physician', 2),

('Internal Medicine', 'internal medicine', 'Physician', 1),
('Family Medicine', 'family medicine', 'Physician', 1),
('Primary Care', 'primary care', 'Physician', 1);


CREATE TABLE clinical_units (
    unit_id SERIAL PRIMARY KEY,
    unit_category TEXT NOT NULL,  -- Nursing, Radiology, Laboratory, Dental, Pharmacy
    unit_name TEXT NOT NULL,
    keyword TEXT NOT NULL,
    priority INT NOT NULL DEFAULT 1
);

-- Nursing units
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Nursing', 'Nurse', 'nurse'),
('Nursing', 'Nurse', 'nurse practitioner'),
('Nursing', 'Nurse', 'registered nurse'),
('Nursing', 'Nursing Technician', 'nursing tech'),
('Nursing', 'Nursing Assistant', 'nursing assistant'),
('Nursing', 'Nursing Director', 'director of nursing'),
('Nursing', 'Nursing Director', 'nursing director'),
('Nursing', 'Nursing Manager', 'nursing manager');

-- Radiology units
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Radiology Dept', 'Radiology Technologist', 'mri technologist'),
('Radiology Dept', 'Radiology Technologist', 'radiology technologist'),
('Radiology Dept', 'Radiology Technologist', 'ct technologist'),
('Radiology Dept', 'Radiology Technologist', 'x-ray technologist'),
('Radiology Dept', 'Radiology Technologist', 'ultrasound technologist'),
('Radiology Dept', 'Radiology Technician', 'ultrasound technician'),
('Radiology Dept', 'Radiology Technician', 'radiology technician'),
('Radiology Dept', 'Radiology Technician', 'x-ray technician'),
('Radiology Dept', 'Radiology Technician', 'mri technician'),
('Radiology Dept', 'Radiology Assistant', 'radiology assistant');

-- Laboratory units
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Medical Laboratory', 'Laboratory Scientist', 'lab scientist'),
('Medical Laboratory', 'Laboratory Scientist', 'laboratory scientist'),
('Medical Laboratory', 'Laboratory Technician', 'lab technician'),
('Medical Laboratory', 'Laboratory Technician', 'laboratory technician'),
('Medical Laboratory', 'Laboratory Technologist', 'laboratory technologist'),
('Medical Laboratory', 'Laboratory Technologist', 'lab technologist'),
('Medical Laboratory', 'Laboratory Assistant', 'lab assistant'),
('Medical Laboratory', 'Laboratory Assistant', 'laboratory assistant'),
('Medical Laboratory', 'Laboratory Medicine', 'laboratory medicine'),
('Medical Laboratory', 'Phlebotomy', 'phlebotomist'),
('Medical Laboratory', 'Laboratory Supervisor', 'laboratory supervisor'),
('Medical Laboratory', 'Laboratory Supervisor', 'lab supervisor');

-- Dental units
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Dental', 'Dentist', 'dentist'),
('Dental', 'Dental Therapist', 'dental hygienist'),
('Dental', 'Dental Assistant', 'dental assistant');

-- Pharmacy units
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Pharmacy', 'Pharmacist', 'pharmacist'),
('Pharmacy', 'Pharmacy Technician', 'pharmacy tech'),
('Pharmacy', 'Pharmacy Director', 'director of pharmacy'),
('Pharmacy', 'Pharmacy Director', 'pharmacy director'),
('Pharmacy', 'Pharmacy Manager', 'pharmacy manager'),
('Pharmacy', 'Pharmacy Intern', 'pharmacy intern'),
('Pharmacy', 'Customer Service', 'pharmacy customer'),
('Pharmacy', 'Pharmacy Clerk', 'pharmacy clerk');


-- Optometry Unit
INSERT INTO clinical_units (unit_category, unit_name, keyword) VALUES
('Optometry', 'Optometrist', 'optometrist'),
('Optometry', 'Optometric Technician', 'optometric tech'),
('Optometry', 'Optometric Technician', 'optometric assistant'),
('Optometry', 'Optometric Technician', 'ophthalmic assistant'),
('Optometry', 'Optician', 'optician');




CREATE OR REPLACE VIEW vw_job_role AS
SELECT DISTINCT ON (jp.job_id)
    jp.job_id,
    cr.role_name,
    cr.priority AS role_priority,
    cr.keyword AS role_keyword
FROM job_postings jp
JOIN clinical_role cr
  ON jp.title ILIKE '%' || cr.keyword || '%'
ORDER BY
    jp.job_id,
    cr.priority ASC;


CREATE OR REPLACE VIEW vw_job_specialty AS
SELECT DISTINCT ON (jp.job_id)
    jp.job_id,
    cs.specialty_name,
    cs.priority AS specialty_priority,
    cs.keyword AS specialty_keyword
FROM job_postings jp
JOIN vw_job_role r
  ON jp.job_id = r.job_id
JOIN clinical_specialty cs
  ON jp.title ILIKE '%' || cs.keyword || '%'
 AND cs.applies_to_role = r.role_name
ORDER BY
    jp.job_id,
    cs.priority ASC;


CREATE OR REPLACE VIEW vw_job_unit AS
SELECT DISTINCT ON (jp.job_id)
    jp.job_id,
    cu.unit_category,
    cu.unit_name,
    cu.priority AS unit_priority,
    cu.keyword AS unit_keyword
FROM job_postings jp
JOIN vw_job_role r
    ON jp.job_id = r.job_id
JOIN clinical_units cu
    ON jp.title ILIKE '%' || cu.keyword || '%'
   AND (
        cu.applies_to_role IS NULL
        OR cu.applies_to_role = r.role_name
   )
ORDER BY
    jp.job_id,
    cu.priority ASC;



CREATE OR REPLACE VIEW fact_healthcare_job AS
SELECT
    jp.job_id,
    jp.title,
    jp.company_id,
    jp.location,
    jp.listed_time,
    jp.closed_time,
    jp.formatted_work_type AS work_type,
    jp.applies           AS job_applied,
    jp.views,
    jp.remote_allowed,
    jp.sponsored,
    jp.posting_domain,

    -- ROLE
    COALESCE(r.role_name, 'Unspecified Role') AS role_name,

    -- SPECIALTY
    COALESCE(
        s.specialty_name,
        CASE
            WHEN r.role_name = 'Physician' THEN 'General Medicine'
            WHEN r.role_name = 'Nurse' THEN 'General Nursing'
            ELSE 'Unspecified Specialty'
        END
    ) AS specialty_name,

    -- UNIT
    COALESCE(u.unit_category, 'Unspecified Unit') AS unit_category,
    COALESCE(u.unit_name, 'Unspecified Unit')     AS unit_name

FROM job_postings jp
LEFT JOIN vw_job_role r
    ON jp.job_id = r.job_id
LEFT JOIN vw_job_specialty s
    ON jp.job_id = s.job_id
LEFT JOIN vw_job_unit u
    ON jp.job_id = u.job_id;



CREATE OR REPLACE VIEW dim_role AS
SELECT DISTINCT
    r.role_name,
    COALESCE(r.role_name, 'Unspecified Role') AS role_label
FROM vw_job_role r
UNION
SELECT
    'Unspecified Role' AS role_name,
    'Unspecified Role' AS role_label;


CREATE OR REPLACE VIEW dim_specialty AS
SELECT DISTINCT
    COALESCE(
        s.specialty_name,
        CASE
            WHEN r.role_name = 'Physician' THEN 'General Medicine'
            WHEN r.role_name = 'Nurse' THEN 'General Nursing'
            ELSE 'Unspecified Specialty'
        END
    ) AS specialty_name
FROM vw_job_role r
LEFT JOIN vw_job_specialty s
    ON r.job_id = s.job_id
UNION
SELECT 'Unspecified Specialty';

CREATE OR REPLACE VIEW dim_unit AS
SELECT DISTINCT
    COALESCE(u.unit_category, 'Unspecified Unit') AS unit_category,
    COALESCE(u.unit_name, 'Unspecified Unit') AS unit_name
FROM vw_job_unit u
UNION
SELECT
    'Unspecified Unit',
    'Unspecified Unit';


 CREATE TABLE currency_conversion (
    currency_code TEXT PRIMARY KEY,
    usd_rate NUMERIC(10, 6) NOT NULL
);


INSERT INTO currency_conversion (currency_code, usd_rate) VALUES
('USD', 1.000000),
('EUR', 1.080000),
('GBP', 1.270000),
('AUD', 0.660000),
('CAD', 0.740000),
('BBD', 0.500000);



CREATE OR REPLACE VIEW fact_healthcare_salary AS
SELECT
    hj.job_id,
    js.salary_id,
    js.currency,
    js.compensation_type,
    js.pay_period,

    /* Hourly salary (native currency) */
    CASE 
        WHEN js.pay_period = 'HOURLY' THEN
            COALESCE(
                js.med_salary,
                (js.min_salary + js.max_salary) / 2,
                js.min_salary,
                js.max_salary
            )
    END AS salary_hourly,

    /* Yearly salary (native currency) */
    CASE 
        WHEN js.pay_period = 'YEARLY' THEN
            COALESCE(
                js.med_salary,
                (js.min_salary + js.max_salary) / 2,
                js.min_salary,
                js.max_salary
            )
    END AS salary_yearly,

    /* Hourly salary in USD */
    CASE 
        WHEN js.pay_period = 'HOURLY' THEN
            ROUND(
                (
                    COALESCE(
                        js.med_salary,
                        (js.min_salary + js.max_salary) / 2,
                        js.min_salary,
                        js.max_salary
                    ) * cc.usd_rate
                )::NUMERIC,
                2
            )
    END AS salary_hourly_usd,

    /* Yearly salary in USD */
    CASE 
        WHEN js.pay_period = 'YEARLY' THEN
            ROUND(
                (
                    COALESCE(
                        js.med_salary,
                        (js.min_salary + js.max_salary) / 2,
                        js.min_salary,
                        js.max_salary
                    ) * cc.usd_rate
                )::NUMERIC,
                2
            )
    END AS salary_yearly_usd

FROM fact_healthcare_job hj
JOIN job_salaries js
    ON hj.job_id = js.job_id
LEFT JOIN currency_conversion cc
    ON js.currency = cc.currency_code
WHERE salary_yearly_usd IS NOT NULL    
;



CREATE OR REPLACE VIEW dim_healthcare_company AS
SELECT DISTINCT
    c.company_id,
    c.name        AS company_name,
    c.country,
    c.state,
    c.city
FROM companies c
LEFT JOIN fact_healthcare_job hj ON
c.company_id = hj.company_id;


CREATE OR REPLACE VIEW fact_employee_count AS
SELECT
    ec.company_id,
    ec.employee_count,
    ec.time_recorded,
    hj.job_id 
FROM employee_counts ec
LEFT JOIN fact_healthcare_job hj ON
ec.company_id = hj.company_id;


CREATE OR REPLACE VIEW fact_job_benefit AS
SELECT
    jb.job_id,
    jb.type     AS benefit_type,
    jb.inferred
FROM job_benefits jb
LEFT JOIN fact_healthcare_job hj ON
jb.job_id = hj.job_id;


