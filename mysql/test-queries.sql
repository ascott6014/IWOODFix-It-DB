use iwood;

-- gets all employees with their addresses
 select concat(emp.first_name, " ", emp.last_name) as name, emp.phone, emp.email,
	ad.home_address, ad.city, s.state_name, ad. zip
from employees emp
join addresses ad on emp.employee_id = ad.employee_id
join states s on ad.state_id = s.state_id
where ad.is_active = true
order by name;

-- gets all customers with their info
select * from customers;

-- gets different types of items
select * from items where sell_item = true;
Select * from items where repair_item = true;
select * from items where install_item = true;

select * from orders;
select * from installs;
select * from repairs;

-- gets all customers with all theeir order, install, repair info		BAD QUERY DUPLICATE INFO
select c.customer_id, concat(c.first_name, " ", c.last_name) as "Name",
	o.order_id, o.order_date, o.order_total,
    i.install_id, i.description, i.cost, i.install_date,
    r.repair_id, r.item_id, it.item_name, r.problem, r.solution, r.repair_cost, r.repair_date
from customers c
left join orders o on c.customer_id = o.customer_id
left join installs i on c.customer_id = i.customer_id
left join repairs r on c.customer_id = r.customer_id
left join items it on r.item_id = it.item_id
order by "Name";

