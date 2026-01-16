-- Create database Homework_session06_08
create database Homework_session06_08;
-- Create table customer
create table customer(
	id serial primary key,
	name varchar(100)
);
create table orders(
	id serial primary key,
	customer_id int,
	order_date date,
	total_amount numeric(10,2)
);

insert into customer(name) values
    ('Nguyễn Văn An'),
    ('Trần Thị Bích'),
    ('Lê Hoàng Cường'),
    ('Phạm Minh Dũng'),
    ('Vũ Thu Hà');
insert into orders (customer_id, order_date, total_amount) values
    (1, '2024-01-10', 500000.00),
    (2, '2024-01-12', 1200000.00),
    (1, '2024-01-15', 300000.00),
    (3, '2024-01-20', 4500000.00),
    (4, '2024-02-05', 150000.00),
    (2, '2024-02-10', 2000000.00),
    (1, '2024-02-15', 700000.00),
    (3, '2024-03-01', 3000000.00),
    (4, '2024-03-05', 500000.00),
    (2, '2024-03-10', 800000.00);

select * from orders;
select * from customer;
-- Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần
select c.name, sum(o.total_amount)
from customer c join orders o on c.id = o.customer_id
group by c.id, c.name
order by sum(o.total_amount) desc;

-- Tìm khách hàng có tổng chi tiêu cao nhất (dùng Subquery với MAX)
select c.name, sum(o.total_amount)
from customer c join orders o on c.id = o.customer_id
group by c.id, c.name
having sum(o.total_amount) = (
	select max(total_sum)
	from (
		select sum(total_amount) as total_sum
		from orders
		group by customer_id
	)
);

-- Liệt kê khách hàng chưa từng mua hàng (LEFT JOIN + IS NULL)
select c.name
from customer c left join orders o on c.id = o.customer_id
where o.id is null;

-- Hiển thị khách hàng có tổng chi tiêu > trung bình của toàn bộ khách hàng 
select c.name, sum(o.total_amount)
from customer c join orders o on c.id = o.customer_id
group by c.id, c.name
having sum(o.total_amount) > (
	select avg(sum_total)
	from (
		select sum(total_amount) as sum_total
		from orders
		group by customer_id
	) as sub_table
);