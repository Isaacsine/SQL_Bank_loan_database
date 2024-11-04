-- Sinethemba nkosi
-- Bank_Loan_database SQL

select * from bank_loan_data;

-- 1. Calculating the Total-loan_Applications
select count(id) AS Total_loan_Applications
from bank_loan_data; --Answer = 38576

-- 2a. Calculating the previous_Month to Date loan_Applications
SELECT SUM(total_payment) AS PMTD_loan_Application
FROM bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 11 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;

  -- 2b. Calculating the _Month to Date loan_Applications 
  SELECT SUM(total_payment) AS MTD_loan_Application
FROM bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 12 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;

 -- 3a. Calculating the average_interest_rate
  select AVG(int_rate)*100 as avg_interest_rate 
  from bank_loan_data;--Answer = 12.049%

  -- 3b. average_interest_rate of the 12th month
  select AVG(int_rate)*100 as Month_to_date_interest_rate 
from bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 12 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;--Answer = 10.65%
  -- 3c. average_interest_rate of the 11th month
 select AVG(int_rate)*100 as Month_to_date_interest_rate 
from bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 11 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;--Answer = 12.255%

  -- 4b. (dti stands for Debtors to Income ratio)
  select AVG(cast (dti as float))*100 as previous_month_to_date_avg_dti --(dti stands for Debtors to Income ratio) 
 from bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 11 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;--Answer = 13.862% (previous month)

    select AVG(cast (dti as float))*100 as month_to_date_avg_dti 
 from bank_loan_data
WHERE MONTH(TRY_CONVERT(DATE, issue_date)) = 12 
  AND YEAR(TRY_CONVERT(DATE, issue_date)) = 2021;--Answer = 13.92% 

  -- Good loan and Bad Loan Part 2

  select distinct loan_status
  from bank_loan_data;

select *
from bank_loan_data;

select DISTINCT loan_status
from bank_loan_data;


select
     (count(case when loan_status = 'Fully Paid' or loan_status = 'current' THEN id END)*100)
	 /
	 count(id) as Good_loan_data_percentage
from bank_loan_data; -- answer 86%

SELECT count(id) as  Good_loan_applications
from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current';-- answer = 33243

SELECT sum(loan_amount) as  Good_loan_funded_amount
from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current';--Answer = 370224850

SELECT sum(total_payment) as  Good_loan_Received_amount
from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current';--answer = 435786170 

 select
     (count(case when loan_status = 'Charged off' THEN id END)*100)
	 /
	 count(id) as BAD_loan_data_percentage
from bank_loan_data;--answer = 13%

SELECT count(id) as  Bad_loan_applications
from bank_loan_data
where loan_status = 'Charged off';-- Answer = 5333

SELECT sum(loan_amount) as	Bad_loan_funded_amount
from bank_loan_data
where loan_status = 'Charged off'; --Answer = 65532225

SELECT sum(total_payment) as Bad_loan_Received_amount
from bank_loan_data
where loan_status = 'Charged off'; --Answer = 37284763


-- Creating tables part 3 'Sinethemba Nkosi'

select 
       loan_status,
	   count(id) AS Total_loan_appplications,
	   sum(total_payment) as total_Amount_Received,
	   sum(loan_amount) as Total_amount_funded,
	   AVG(int_rate * 100) as interest_rate,
	   Avg(cast(dti as float) * 100) as Debtors_to_ratio
	  From
	  bank_loan_data
	  Group by loan_status
	  order by 1;








select * 
from bank_loan_data;

select
     month(try_convert(date, issue_date)),
     DATENAME(Month, try_convert(date, issue_date)) as Month_name,
	 count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by month(try_convert(date, issue_date)), DATENAME(month, try_convert(date, issue_date))
order by month(try_convert(date, issue_date)) 

select 
      address_state,
	   count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by address_state
order by count(id)

select 
      term,
	   count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by term
order by term

select 
      emp_length,
	   count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by emp_length
order by count(id)

select 
      purpose,
	   count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by purpose
order by count(id)

select 
      home_ownership,
	   count(id) as Total_loan_applications,
	 sum(loan_amount) AS Total_funded_Amount,
	 sum(total_payment) as Total_received_Amount
from bank_loan_data
group by home_ownership
order by count(id)
