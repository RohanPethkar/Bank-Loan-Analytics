create database banking;
use banking;
## Load finance_1finance_1
create table Finance_1
(
id int ,
member_id int ,
loan_amnt int ,
funded_amnt int ,
funded_amnt_inv double ,
term text ,
int_rate text ,
installment double ,
grade text ,
sub_grade text ,
emp_title text ,
emp_length text ,
home_ownership text, 
annual_inc int ,
verification_status text ,
issue_d datetime ,
loan_status text ,
pymnt_plan text ,
desc_ text ,
purpose text ,
title text ,
zip_code text ,
addr_state text ,
dti double
);
LOAD DATA INFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//Finance_1.csv'
INTO TABLE Finance_1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows;

##Load Finance_2
create table Finance_2(
id int ,
delinq_2yrs int ,
earliest_cr_line text ,
inq_last_6mths int ,
mths_since_last_delinq text ,
mths_since_last_record text ,
open_acc int ,
pub_rec int ,
revol_bal int ,
revol_util text ,
total_acc int, 
initial_list_status text ,
out_prncp int ,
out_prncp_inv int ,
total_pymnt double ,
total_pymnt_inv double ,
total_rec_prncp double ,
total_rec_int double ,
total_rec_late_fee int ,
recoveries int ,
collection_recovery_fee int ,
last_pymnt_d datetime,
last_pymnt_amnt double ,
next_pymnt_d text ,
last_credit_pull_d datetime
);
# alter table finance_2 modify last_credit_pull_d datetime;

LOAD DATA INFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//Finance_2.csv'
INTO TABLE Finance_2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows;


##kpi_1 Year wise loan amount Stats


select year(issue_d) as Year_,sum(Loan_amnt) as Total_Loan_Amount
from finance_1 group by year_
order by year_ desc;

##kpi_2 Grade and sub grade wise revol_bal
select T1.grade , T1.sub_grade , SUM(T2.revol_bal) AS Total_Revol_Balance 
from finance_1 T1 join finance_2 T2 on T1.id = T2.id 
group by grade,sub_grade ORDER BY GRADE asc;

##kpi_3 Total Payment for Verified Status Vs Total Payment for Non Verified Status
select T1.verification_status, round(sum(T2.total_pymnt)) as Total_Payment 
from finance_1 T1 join finance_2 T2 on T1.id = T2.id  group by verification_status;

##kpi_4 State wise and last credit pull d wise loan status
select f1.addr_state,year(last_credit_pull_d),monthname(last_credit_pull_d),f1.loan_status,count(loan_status) as total 
from finance_1 f1 join finance_2 f2 on f1.id= f2.id 
group by addr_state,last_credit_pull_d,loan_Status order by year(last_credit_pull_d);



##kpi-5 Home ownership Vs last payment date stats
select year(T2.last_pymnt_d) as year_ ,T1.home_ownership,count(T1.home_ownership) 
from finance_1 T1 join finance_2 T2 on T1.id=T2.id
# where year(T2.last_pymnt_d) is not null
group by T1.home_ownership,year_ order by Year_ desc ;










