# 🌟Gold Layer Data Dictionary

## Overview

The **Gold Layer** represents the business-level data model designed to support analytics, dashboards, and reporting use cases.  
It follows a **star schema** approach, consisting of **dimension tables** and **fact tables** optimized for analytical queries.

This layer is typically consumed by BI tools, data analysts, and downstream machine learning workloads.

---

## Schema Design

- **Dimensions** store descriptive attributes used for filtering, grouping, and slicing data.
- **Facts** store measurable business events and link to dimensions using surrogate keys.

---

### 1. gold.dim_customers

- **Purpose:** Stores customer deails enriched with demographic and geographic attributes.
- **Columns:**

| Column Name      | Data Type     | Description |
|------------------|---------------|-------------|
| customer_key    | INT           | Surrogate key uniquely identifying each customer record. |
| customer_id     | INT           | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50)  | Alphanumeric customer identifier used for tracking and referencing. |
| first_name      | NVARCHAR(50)  | Customer’s first name. |
| last_name       | NVARCHAR(50)  | Customer’s last name or family name. |
| country         | NVARCHAR(50)  | Country of residence (e.g., Australia). |
| marital_status  | NVARCHAR(50)  | Marital status (e.g., Married, Single). |
| gender          | NVARCHAR(50)  | Gender (e.g., Male, Female, n/a). |
| birthdate       | DATE          | Customer date of birth (YYYY-MM-DD). |
| create_date     | DATE          | Record creation timestamp. |

---

### 2. gold.dim_products

- **Purpose:** Provides information about the products and their attributes.
- **Columns:**

| Column Name           | Data Type     | Description |
|----------------------|---------------|-------------|
| product_key          | INT           | Surrogate key uniquely identifying each product. |
| product_id           | INT           | Internal product identifier. |
| product_number       | NVARCHAR(50)  | Alphanumeric product code used for inventory and categorization. |
| product_name         | NVARCHAR(50)  | Descriptive product name. |
| category_id          | NVARCHAR(50)  | Product category identifier. |
| category             | NVARCHAR(50)  | High-level product classification (e.g., Bikes, Components). |
| subcategory          | NVARCHAR(50)  | Detailed product classification. |
| maintenance_required | NVARCHAR(50)  | Indicates whether maintenance is required (Yes/No). |
| cost                 | INT           | Base cost of the product. |
| product_line         | NVARCHAR(50)  | Product line or series (e.g., Road, Mountain). |
| start_date           | DATE          | Product availability start date. |

---

### 3. gold.fact_sales

- **Purpose:** Stores transactional sales data for Analytical purposes.
- **Columns:**

| Column Name    | Data Type     | Description |
|---------------|---------------|-------------|
| order_number  | NVARCHAR(50)  | Unique sales order identifier (e.g., SO54496). |
| product_key   | INT           | Foreign key referencing `gold.dim_products`. |
| customer_key  | INT           | Foreign key referencing `gold.dim_customers`. |
| order_date    | DATE          | Date the order was placed. |
| shipping_date | DATE          | Date the order was shipped. |
| due_date      | DATE          | Payment due date. |
| sales_amount  | INT           | Total monetary value of the order line. |
| quantity      | INT           | Number of units ordered. |
| price         | INT           | Unit price of the product. |

---
