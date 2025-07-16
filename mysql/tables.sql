drop database if exists iwood;
create database iwood;
use iwood;

-- Customer info

create table customers (
	customer_id int primary key auto_increment,
    first_name 	varchar(255) not null,
    last_name 	varchar(255) not null,
    address 	varchar(255) not null,
    city		varchar(255) not null,
    state		varchar(2) not null,
    zip			varchar(10) not null,
    phone		varchar(20) not null,
    email 		varchar(255) not null,
    notes		text
);

create table customer_visits (
	customer_visits_id		int primary key auto_increment,
    customer_id				int not null,
    visit_type				enum('Order', 'Repair', 'Install') not null,
    visit_date				datetime not null default current_timestamp,
    CONSTRAINT customer_visits_fk_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- Employee info

create table states (
	state_id 		int primary key auto_increment,
    state_name		varchar(255) not null,
    abbreviation	varchar(2) not null
);

create table state_tax_log (
	state_tax_log_id    int primary key auto_increment,
    state_id    int not null,
    percentage  decimal(10, 2) not null,
    start_date  datetime not null,
    end_date    datetime,
    CONSTRAINT state_tax_log_fk_states FOREIGN KEY (state_id) REFERENCES states (state_id)
);

create table federal_tax_log(
  federal_tax_log_id    int primary key auto_increment,
  percentage            decimal(10,2) not null,
  start_date            datetime not null,
  end_date              datetime,
  is_active             boolean default true
);

create table employees (
	employee_id				int primary key auto_increment,
    first_name   varchar(255) not null,
    last_name    varchar(255) not null,
    phone        varchar(20) not null,
    email        varchar(255) not null
);

create table addresses (
  address_id    int primary key auto_increment,
    employee_id int not null,
    home_address     varchar(255) not null,
    city             varchar(255) not null,
    state_id         int not null,
    zip              varchar(10) not null,
    is_active        boolean not null,
    CONSTRAINT addresses_fk_states FOREIGN KEY (state_id) REFERENCES states (state_id),
    CONSTRAINT addresses_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

create table titles (
  title_id    int primary key auto_increment,
    title_name    varchar(255) not null,
    description   text not null
);

create table title_log (
  title_log_id    int primary key auto_increment,
    title_id      int not null,
    employee_id   int not null,
    start_date    datetime not null,
    end_date      datetime,
    CONSTRAINT title_log_fk_titles FOREIGN KEY (title_id) REFERENCES titles (title_id),
    CONSTRAINT tile_log_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

create table tenure (
  tenure_id   int primary key auto_increment,
    employee_id   int not null,
    start_date    datetime not null,
    end_date      datetime,
    end_reason    text,
    CONSTRAINT tenure_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

create table time_sheets (
  time_sheet_id   int primary key auto_increment,
  employee_id     int not null,
  start_date      date not null,
  end_date        date not null,
  hours_worked    decimal (10,2) not null default 0,
  CONSTRAINT time_sheets_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

create table pay_rates (
  pay_rate_id     int primary key auto_increment,
    employee_id     int not null,
    hourly_rate     decimal(10,2),
    salary          decimal(10,2),
    start_date      datetime not null,
    end_date        datetime,
    is_active       boolean not null,
    CONSTRAINT pay_rates_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

create table pay_log (
  pay_log_id          int primary key auto_increment,
  employee_id         int not null,
  payment_date        datetime not null,
  gross_amount        decimal(10,2),
  state_tax_log_id    int not null,
  federal_tax_log_id  int not null,
  net_amount          decimal(10,2),
  CONSTRAINT pay_log_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id),
  CONSTRAINT pay_log_fk_state_tax_log FOREIGN KEY (state_tax_log_id) REFERENCES state_tax_log (state_tax_log_id),
  CONSTRAINT pay_log_fk_federal_tax_log FOREIGN KEY (federal_tax_log_id) REFERENCES federal_tax_log (federal_tax_log_id)
);

create table items (
	item_id 		int primary key auto_increment,
  item_name		varchar(255) not null,
  item_color  varchar(255) not null,
  item_model  varchar(255) not null,
  description 	varchar(255) not null,
  cost        decimal(10,2) not null,
  price			decimal(10,2) not null,
  quantity		int not null,
  sell_item    boolean not null,
  repair_item  boolean not null,
  install_item boolean not null
);

create table item_price_log (
	item_price_log_id		int primary key auto_increment,
    item_id					int not null,
    price					decimal(10,2),
    start_date				date not null,
    end_date				date,
    CONSTRAINT item_price_log_fk_items FOREIGN KEY (item_id) REFERENCES items(item_id)
);

create table installs (
	install_id		int primary key auto_increment,
    customer_id		int not null,
    employee_id	int	not null,
    description 	text,
    cost			decimal(10,2) not null,
    install_date	date,
    CONSTRAINT installs_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT installs_fk_employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

create table repairs (
	repair_id 			int primary key auto_increment,
    customer_id 		int not null,
    item_id			int not null,
    problem	varchar(255) not null,
    solution varchar(255) not null,
    repair_cost			decimal(10,2) not null,
    repair_date			date not null,
    CONSTRAINT repairs_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT repairs_fk_items FOREIGN KEY (item_id) REFERENCES items(item_id)
);

create table orders (
	order_id 		int primary key auto_increment,
    customer_id		int not null,
    order_date		date not null,
    order_total		decimal(10,2),
	CONSTRAINT orders_fk_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

create table install_items (
  install_item_id   int primary key auto_increment,
  install_id        int not null,
  item_id           int not null,
  install_item_quantity   int not null,
  CONSTRAINT install_items_fk_installs FOREIGN KEY (install_id) REFERENCES installs (install_id),
  CONSTRAINT install_items_fk_items FOREIGN KEY (item_id) REFERENCES items (item_id)
);

create table repair_items (
	repair_item_id 	int primary key auto_increment,
    repair_id 		int not null,
    item_id 		int not null,
    quantity		int not null,
    CONSTRAINT repair_items_fk_repairs FOREIGN KEY (repair_id) REFERENCES repairs (repair_id),
    CONSTRAINT repair_items_fk_items FOREIGN KEY (item_id)	REFERENCES items (item_id)
);

create table order_items (
	order_item_id		int primary key auto_increment,
    order_id			int not null,
    item_id			int not null,
    quantity			int not null,
    total_price				decimal(10,2),
    CONSTRAINT order_items_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT order_items_fk_items FOREIGN KEY (item_id) REFERENCES items(item_id)
);


create table invoices (
	invoice_id		int primary key auto_increment,
    customer_id		int not null,
    install_id    int,
    repair_id     int,
    order_id      int,
    invoice_date	date not null,
    status			enum('Unpaid', 'Paid', 'Partially Paid', 'Overdue') default 'Unpaid',
    subtotal		decimal(10,2) not null,
    tax				decimal(10,2) default 10.25 not null,
    tax_amount		decimal(10,2) not null,
    total			decimal(10,2) not null,
    CONSTRAINT invoices_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create table payments (
	payment_id			int primary key auto_increment,
    invoice_id			int not null,
    payment_amount		decimal(10,2) not null default 0,
    payment_method		varchar(255) not null,
	payment_date		datetime not null,
    CONSTRAINT payments_fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id)    
);







