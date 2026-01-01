# Retail Transaction Database

## 📌 Overview
This project represents a **Retail Transaction Database** designed to store and analyze customer purchases, product categories, and transaction details.  
It follows a relational database structure with clearly defined relationships between customers, transactions, and product categories.

The database is useful for:
- Sales analysis
- Customer behavior analysis
- Product category performance
- Store-type comparisons

---

## 🗂️ Database Schema

The database consists of **three main tables**:

1. **Customer**
2. **Transactions**
3. **Product Category Information (prod_cat_info)**

### 📷 ER Diagram
![Database Diagram](database_diagram.png)

---

## 📋 Table Descriptions

### 1️⃣ Customer Table
Stores customer demographic information.

| Column Name   | Data Description |
|---------------|------------------|
| customer_Id   | Unique customer identifier (Primary Key) |
| DOB           | Date of Birth of the customer |
| Gender        | Gender of the customer |
| city_code     | Code representing customer’s city |

---

### 2️⃣ Transactions Table
Stores transaction-level sales data.

| Column Name       | Data Description |
|-------------------|------------------|
| transaction_id    | Unique transaction identifier (Primary Key) |
| cust_id           | Customer ID (Foreign Key → Customer.customer_Id) |
| tran_date         | Date of transaction |
| prod_subcat_code  | Product sub-category code |
| prod_cat_code     | Product category code |
| Qty               | Quantity purchased |
| Rate              | Price per unit |
| Tax               | Tax applied |
| total_amt         | Total transaction amount |
| Store_type        | Type of store (e.g., Online, Retail) |

---

### 3️⃣ Product Category Information Table
Stores product category and sub-category details.

| Column Name        | Data Description |
|--------------------|------------------|
| prod_cat_code      | Product category code |
| prod_cat           | Product category name |
| prod_sub_cat_code  | Product sub-category code |
| prod_subcat        | Product sub-category name |

---

## 🔗 Relationships

- **Customer ↔ Transactions**
  - One customer can have multiple transactions.
  - `Transactions.cust_id` → `Customer.customer_Id`

- **Transactions ↔ Product Category Info**
  - Each transaction is linked to a product category and sub-category.
  - `prod_cat_code` and `prod_subcat_code` connect transaction data with product details.

---

## 📊 Key Business Use Cases

- Customer age and gender-based purchase analysis
- City-wise sales performance
- Product category and sub-category revenue analysis
- Store-type performance comparison
- Transaction volume and revenue trends over time

---

## 🛠️ Technologies Used
- SQL (Relational Database)
- ER Modeling
- Retail Analytics Concepts

---

## 📁 Files Included
- `database_diagram.png` – Entity Relationship Diagram
- `retail_data_solution.sql` – SQL scripts for queries/analysis
- `README.md` – Project documentation

---

## ✅ Future Enhancements
- Add indexes for performance optimization
- Introduce payment and returns tables
- Create analytical views for dashboards

---

### ✨ Author
**Priya Tripathi**

---
