/*
=================================================================================================
Quality Checks
=================================================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicates primary keys.
    - Unwanted spaces in string fields.
    - Data Standardization and Consistency.
    - Invalid data ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading silver layer.
    - Investigate and resolve any discrepancies found during the checks.
==================================================================================================
*/

-- =================================================================================
-- Checking 'silver.crm_cust_info'
-- =================================================================================

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
	cst_id,
	COUNT(*) AS Duplicates
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)  > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectations: No Results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- Data Standarization & Consistency
SELECT DISTINCT(cst_gndr)
FROM silver.crm_cust_info;

SELECT DISTINCT(cst_marital_status)
FROM silver.crm_cust_info;

-- =================================================================================
-- Checking 'silver.crm_prd_info'
-- =================================================================================

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
	prd_id,
	COUNT(*) AS Duplicates
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)  > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expectations: No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs or Negative Numbers
-- Expectations: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost <0;

-- Data Standarization & Consistency
SELECT DISTINCT(prd_line)
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- =================================================================================
-- Checking 'silver.crm_sales_details'
-- =================================================================================

-- Check for Inavlid Dates
SELECT
*
FROM silver.crm_sales_details
WHERE sls_ship_dt IS NULL
OR sls_ship_dt > '2050-01-01'
OR sls_ship_dt < '1900-01-01'

-- Check for Inavlid Date Order
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt 

-- Check Data Consistency: Between Sales, Quantity and Price 
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or Negative.
SELECT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity,sls_price

-- =================================================================================
-- Checking 'silver.erp_cust_az12'
-- =================================================================================

-- Identify Out-of-Range Dates
SELECT 
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1926-01-01' OR bdate > GETDATE()

--Data Standarization & Consistency
SELECT DISTINCT(gen)
FROM silver.erp_cust_az12

-- =================================================================================
-- Checking 'silver.erp_loc_a101'
-- =================================================================================

-- Data Standarization & Consistency
SELECT
DISTINCT(cntry)
FROM silver.erp_loc_a101;

-- =================================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- =================================================================================

-- Check for Unwanted Spaces
-- Expectation: No Resullt
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance)

-- Data Standarization & Consistency
SELECT DISTINCT maintenance 
FROM silver.erp_px_cat_g1v2
