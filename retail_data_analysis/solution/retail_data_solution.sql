--Data_prep

--1. what is the total number of rows in each of the 3 tables in the database .
select 'Customer' as 'table_name', count(customer_id) as [rows] 
from Customer 
union all
select 'prod_cat_info' as 'table_name', count(*) as [rows] 
from prod_cat_info
union all
select 'Transactions' as 'table_name', count(*) as [rows] 
from Transactions

--2. what is the total number of transactions that have a return?
select count(distinct transaction_id) as total_trans      
from Transactions
where Qty < 0

--3. 
select CONVERT(date, tran_date, 105)  as trans_dates
from Transactions

--4. 
select DATEDIFF(YEAR, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) as trans_years,
DATEDIFF(month, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) as trans_months,
DATEDIFF(DAY, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) as trans_days
from Transactions

--5.
select prod_cat, prod_subcat
from prod_cat_info
where prod_subcat like '%DIY%'


-- Data_analysis
--1.
select top 1Store_type,COUNT(Store_type) as frequency
from Transactions
group by Store_type
order by frequency desc

--2.
select Gender, COUNT(customer_Id) as cust_count
from Customer
group by Gender
order by cust_count
offset 1 rows
fetch next 2 rows only

---OR

select Gender, COUNT(customer_Id) as cust_count
from Customer
where Gender is not null
group by Gender

--3.
select top 1 COUNT(customer_Id) as cust_count, city_code
from Customer
group by city_code
order by cust_count desc

--4.
select prod_cat, prod_subcat 
from prod_cat_info
where prod_cat = 'books'

--5.
select prod_cat_code, COUNT(Qty) as qty_count    -----------Doubt
from Transactions
group by prod_cat_code
order by qty_count desc

--6.
select sum(total_amt) as revenue 
from Transactions as t
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code
and t.prod_subcat_code = p.prod_sub_cat_code
where prod_cat = 'books'
			or
	  prod_cat = 'electronics'

--7.
select COUNT(*) as total_cust
    from (
		select c.customer_Id, count(Qty) as qty_count
		from Customer as c
		join Transactions as t
		on c.customer_Id = t.cust_id
		where total_amt > 0
		group by c.customer_Id
		having count(Qty) > 10
		--order by qty_count desc
	) as x

--8.
select sum(total_amt) as revenue
from Transactions as t
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code
and t.prod_subcat_code = p.prod_sub_cat_code
where prod_cat in ('electronics','clothing')
          AND
	Store_type = 'flagship store'
		AND qty>0

--9.
select prod_subcat, sum(total_amt) as revenue 
from Customer as c
join Transactions as t
on c.customer_Id = t.cust_id
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code 
and t.prod_subcat_code = p.prod_sub_cat_code
where Gender = 'M' and prod_cat = 'electronics'
group by Gender, prod_subcat


--10. --------------------------------Doubt-----------------------------------------------------------------
select prod_subcat, sum(total_amt)/(select sum(total_amt)) as percent_sales
from Transactions as t
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code 
and t.prod_subcat_code = p.prod_sub_cat_code
where qty>0
group by prod_subcat, qty
having sum(total_amt) <0

--11.-------------------------------Doubt----------------------------------------------------






---------------------------------------------------------------------------------------
--12.
select top 1 prod_cat, sum(returns) as total_returns from (
select prod_cat, CONVERT(date, tran_date, 105)  as trans_dates, sum(qty) as returns
from Transactions as t
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code 
and t.prod_subcat_code = p.prod_sub_cat_code
where Qty < 0
group by prod_cat, CONVERT(date, tran_date, 105)
having CONVERT(date, tran_date, 105) >=(select dateadd(month, -3, max(CONVERT(date, tran_date, 105))) as cutoff_date from transactions)
 ) as a
group by prod_cat
order by total_returns asc



--13.
select top 1 Store_type, sum(total_amt) as sales, sum(qty) as qty_count
from Transactions
where qty>0
group by Store_type
order by sales desc, qty_count desc

-------------------------------------or----Doubt-------------------------------------------
select top 1 Store_type, sum(total_amt) as sales, sum(qty) as qty_count
from Transactions
group by Store_type
having sum(qty) >0
order by sales desc, qty_count desc

--14.
select prod_cat_code,avg(total_amt) as avg_revenue 
from Transactions
where qty> 0
group by prod_cat_code
having avg(total_amt) >= (select avg(total_amt) as avg_revenue from Transactions where qty> 0)


--select avg(total_amt) as avg_revenue from Transactions where qty> 0 average revenue

--15.

with top_5_cust 
as (
select top 5 prod_cat, sum(qty) as total_qty
from transactions as t
join prod_cat_info as p
on t.prod_cat_code = p.prod_cat_code
and t.prod_subcat_code = p.prod_sub_cat_code
where qty>0
group by prod_cat
order by total_qty desc
), avg_and_revenue
as (

)
select * from avg_and_revenue