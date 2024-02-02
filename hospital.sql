create database hospital_db;
use hospital_db;
select * from patients;
select * from doctors;
select * from admissions;
select * from province_names;

#Show first name, last name, and gender of patients whose gender is 'M'
select first_name,last_name,gender from patients where gender='m';

#Show first name and last name of patients who does not have allergies. (null)
select first_name,last_name from patients where allergies is not null;

#Show first name and last name of patients who have allergies. (null)
select first_name,last_name from patients where allergies is null;

#how first name of patients that start with the letter 'C'
select first_name from patients where first_name like 'C%';


#Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name,last_name from patients where weight between 100 and 120 ;

#Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients set allergies="NKA"
where allergies is null;

#Show first name and last name concatinated into one column to show their full name.
select concat(first_name," ",last_name) as full_name from patients;


#Show first name, last name, and the full province name of each patient.

#Example: 'Ontario' instead of 'ON
SELECT
  first_name,
  last_name,
  province_name
FROM patients as p
  JOIN province_names as pn 
  ON pn.province_id = p.province_id;


#Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

#Show the first_name, last_name, and height of the patient with the greatest height.
select first_name,last_name,height from patients
where 
height=(select max(height) from patients);

#Show all columns for patients who have one of the following patient_ids:
#1,50,25,150,200,159
select * from patients where patient_id in (1,50,25,150,200,159);

#Show the total number of admissions
select count(*) from admissions;

#Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions where admission_date=discharge_date;

#Show the patient id and the total number of admissions for patient_id 579.
SELECT
  patient_id,
  COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id =21 ;

select a.patient_id ,ap.patient_id
 from admissions as a 
 join admissions as ap
on a.patient_id=ap.patient_id 
where a.patient_id=ap.patient_id;

#Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct city from patients where province_id='NS';

#Write a query to find the first_name, last name and birth date of patients 
#who has height greater than 160 and weight greater than 70
select first_name,last_name,birth_date
 from patients
 where height>160 and weight>70;

#Write a query to find list of patients first_name, last_name, and 
#allergies where allergies are not null and are from the city of 'Hamilton';
select first_name,last_name,allergies,city  from patients where allergies is not null and 
city='Hamilton';

#Show unique birth years from patients and order them by ascending.
select distinct year(birth_date)  as  birth_year from patients 
order by birth_year asc;

#Show unique first names from the patients table which only occurs once in the list.

#For example, if two or more people are named 'John' in the first_name column then 
#don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

select distinct first_name from patients ;

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1

#Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long#

SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE '%s' AND LENGTH(first_name) =6;

#Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
#Primary diagnosis is stored in the admissions table.
select patients.patient_id,first_name,last_name from patients
join admissions  
on patients.patient_id=admissions.patient_id
where diagnosis= 'Dementia';

#Display every patient's first_name.
#Order the list by the length of each name and then by alphabetically.

select first_name  from patients order by len(first_name),first_name asc;

#Show the total amount of male patients and the total amount of female patients in the patients table.
#Display the two results in the same row.

SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

#Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
# Show results ordered ascending by allergies then by first_name then by last_name

select first_name,last_name,allergies 
from patients where allergies in ('Penicillin' , 'Morphine') 
order by allergies,first_name,last_name;

#Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id ,diagnosis 
from admissions 
group by patient_id,
diagnosis 
having count(*)>1;

#Show the city and the total number of patients in the city.
#Order from most to least patients and then by city name ascending.

select city ,count(patient_id) as  total_patients 
from patients 
group by city 
order by count(patient_id) desc ,city asc;


#Show first name, last name and role of every person that is either patient or doctor.
#The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' as role FROM patients
    union all
select first_name, last_name, 'Doctor' from doctors;

#Show all allergies ordered by popularity. Remove NULL values from query.
select * from patients;
SELECT
  allergies,
  COUNT(*) AS total_diagnosis
FROM patients
WHERE
  allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC;







