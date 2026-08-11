/*
========================================================================================
Procedure : Silver Quality Checks
Purpose   : 
========================================================================================
*/
--crm_cust_info
SELECT COUNT(*)
FROM SILVER.crm_cust_info;

--check null Id's
SELECT *
FROM SILVER.crm_cust_info
WHERE cst_id IS NULL;

--check duplicate Id's
SELECT cst_id,COUNT(*)
FROM SILVER.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1;

SELECT cst_key,COUNT(*)
FROM SILVER.crm_cust_info
GROUP BY cst_key
HAVING COUNT(*)>1;

--check marital status
SELECT DISTINCT cst_marital_status
FROM SILVER.crm_cust_info;

--check gender 
SELECT DISTINCT cst_gndr
FROM SILVER.crm_cust_info;

--check create date
SELECT cst_create_date
FROM SILVER.crm_cust_info
WHERE cst_create_date > CURRENT_DATE OR cst_create_date IS NULL;

--=========================================================================================
--crm_prd_info
SELECT COUNT(*)
FROM SILVER.crm_prd_info;

--check for null key
SELECT prd_key
FROM SILVER.crm_prd_info
WHERE prd_key IS NULL;

--check prd_line
SELECT DISTINCT prd_line
FROM SILVER.crm_prd_info;

--check date
SELECT prd_start_dt
FROM SILVER.crm_prd_info
WHERE prd_start_dt > CURRENT_DATE;

SELECT prd_start_dt,prd_end_dt
FROM SILVER.crm_prd_info
WHERE prd_start_dt > prd_end_dt;

--======================================================================================
--crm_sales_details
SELECT COUNT(*)
FROM SILVER.crm_sales_details;

--check for null sls_ord_num
SELECT sls_ord_num
FROM SILVER.crm_sales_details
WHERE sls_ord_num IS NULL;

--check for null sls_prd_key
SELECT sls_prd_key
FROM SILVER.crm_sales_details
WHERE sls_prd_key IS NULL;

--check for null sls_cust_id
SELECT sls_cust_id
FROM SILVER.crm_sales_details
WHERE sls_cust_id IS NULL;

--check sales
SELECT sls_sales
FROM SILVER.crm_sales_details
WHERE  sls_sales < 1;

SELECT sls_sales
FROM SILVER.crm_sales_details
WHERE  sls_sales IS NULL;

--check quantity
SELECT sls_quantity
FROM SILVER.crm_sales_details
WHERE  sls_quantity < 1;

SELECT sls_quantity
FROM SILVER.crm_sales_details
WHERE  sls_quantity IS NULL;

--check price
SELECT sls_price,sls_sales,sls_quantity
FROM SILVER.crm_sales_details
WHERE  sls_price < 1;

SELECT sls_sales,sls_quantity,sls_price
FROM SILVER.crm_sales_details
WHERE  sls_price IS NULL;

--=============================================================================
--erp_cust_az12
SELECT COUNT(*)
FROM SILVER.erp_cust_az12;

--check for null Id's
SELECT *
FROM SILVER.erp_cust_az12
WHERE CID IS NULL;

--check gender
SELECT DISTINCT GEN
FROM SILVER.erp_cust_az12;

--=============================================================================
--erp_loc_a101
SELECT COUNT(*)
FROM SILVER.erp_loc_a101;

--check null Id's
SELECT *
FROM SILVER.erp_loc_a101
WHERE CID IS NULL;

--check distinct counties
SELECT DISTINCT CNTRY
FROM SILVER.erp_loc_a101;

--=============================================================================
--erp_px_cat_g1v2
SELECT COUNT(*)
FROM BRONZE.erp_px_cat_g1v2;

--ckeck null Id's
SELECT ID
FROM SILVER.erp_px_cat_g1v2
WHERE ID IS NULL;


--ckeck distinct categories
SELECT DISTINCT CAT
FROM SILVER.erp_px_cat_g1v2;

--ckeck distinct subcategories
SELECT DISTINCT SUBCAT
FROM SILVER.erp_px_cat_g1v2;

--ckeck for valid maintenance
SELECT DISTINCT MAINTENANCE
FROM SILVER.erp_px_cat_g1v2;
--=============================================================================