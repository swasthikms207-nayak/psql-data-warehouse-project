--======================================================================================
--crm_cust_info
SELECT *
FROM BRONZE.crm_cust_info
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.crm_cust_info;

--check null Id's
SELECT *
FROM BRONZE.crm_cust_info
WHERE cst_id IS NULL;

--try if null Id's can be recovered
SELECT COUNT(cst_key)
FROM BRONZE.crm_cust_info
GROUP BY cst_key
HAVING COUNT(cst_key)>1;

--check duplicate Id's
SELECT cst_id,COUNT(*)
FROM BRONZE.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1;

--check for invalid Id's
SELECT cst_id
FROM BRONZE.crm_cust_info
WHERE cst_id !~ '^[0-9]+$';

SELECT cst_id
FROM BRONZE.crm_cust_info
WHERE cst_id :: INTEGER < 1;

--check for invalid keys
SELECT cst_key,*
FROM BRONZE.crm_cust_info
WHERE cst_key NOT LIKE 'AW000%';

--ckeck if the name is null
SELECT cst_firstname
FROM BRONZE.crm_cust_info
WHERE cst_firstname IS NULL;

SELECT cst_lastname
FROM BRONZE.crm_cust_info
WHERE cst_lastname IS NULL;

--check invalid marital status
SELECT DISTINCT cst_marital_status
FROM BRONZE.crm_cust_info;

--check invalid gender
SELECT DISTINCT cst_gndr
FROM BRONZE.crm_cust_info;

--check invalid date
SELECT cst_create_date
FROM BRONZE.crm_cust_info
WHERE cst_create_date :: DATE > CURRENT_DATE;

SELECT cst_create_date
FROM BRONZE.crm_cust_info
WHERE cst_create_date IS NULL;

--===========================================================
--crm_prd_info
SELECT *
FROM BRONZE.crm_prd_info
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.crm_prd_info;

--check null Id's
SELECT prd_id
FROM BRONZE.crm_prd_info
WHERE prd_id IS NULL;

--check duplicate Id's
SELECT prd_id,COUNT(*)
FROM BRONZE.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1;

--check for invalid Id's
SELECT prd_id
FROM BRONZE.crm_prd_info
WHERE prd_id !~ '^[0-9]+$';

SELECT prd_id
FROM BRONZE.crm_prd_info
WHERE prd_id :: INTEGER < 1;

--check for invalid and null prd_key
SELECT SUBSTRING(REPLACE(prd_key,'-','_'),1,5)
FROM BRONZE.crm_prd_info;

SELECT SUBSTRING(REPLACE(prd_key,'-','_'),1,5)
FROM BRONZE.crm_prd_info;

SELECT prd_key
FROM BRONZE.crm_prd_info
WHERE prd_key IS NULL;

--check for invalid and null prd_nm
SELECT prd_nm
FROM BRONZE.crm_prd_info
WHERE prd_nm IS NULL;

--check for invalid prd_cost
SELECT prd_cost
FROM BRONZE.crm_prd_info
WHERE prd_cost IS NULL AND prd_cost :: INTEGER <1;

--check for invalid prd_line
SELECT DISTINCT prd_line
FROM BRONZE.crm_prd_info;

--check invalid date
SELECT prd_start_dt
FROM BRONZE.crm_prd_info
WHERE prd_start_dt :: DATE > CURRENT_DATE;

SELECT prd_start_dt,prd_end_dt
FROM BRONZE.crm_prd_info
WHERE prd_start_dt :: DATE > prd_end_dt :: DATE;

SELECT prd_start_dt
FROM BRONZE.crm_prd_info
WHERE prd_start_dt IS NULL;

SELECT prd_end_dt
FROM BRONZE.crm_prd_info
WHERE prd_end_dt IS NULL;

--======================================================================================
--crm_sales_details
SELECT *
FROM BRONZE.crm_sales_details
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.crm_sales_details;

--check null sls_ord_num
SELECT sls_ord_num
FROM BRONZE.crm_sales_details
WHERE sls_ord_num IS NULL;

--check null sls_prd_key
SELECT sls_prd_key
FROM BRONZE.crm_sales_details
WHERE sls_prd_key IS NULL;

--check null sls_cust_id
SELECT sls_cust_id
FROM BRONZE.crm_sales_details
WHERE sls_cust_id IS NULL;
 
--check for invalid date
SELECT sls_order_dt
FROM BRONZE.crm_sales_details
WHERE sls_order_dt IS NULL;

SELECT sls_ship_dt
FROM BRONZE.crm_sales_details
WHERE sls_ship_dt IS NULL;

SELECT sls_due_dt
FROM BRONZE.crm_sales_details
WHERE  sls_due_dt IS NULL;

--check for invalid number of sales
SELECT sls_sales,*
FROM BRONZE.crm_sales_details
WHERE  sls_sales :: INTEGER < 1;

--check for invalid number of quantity
SELECT sls_quantity
FROM BRONZE.crm_sales_details
WHERE  sls_quantity :: INTEGER < 1;

--check for invalid price
SELECT sls_price
FROM BRONZE.crm_sales_details
WHERE  sls_price :: INTEGER < 1;

--=============================================================================
--erp_cust_az12
SELECT *
FROM BRONZE.erp_cust_az12
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.erp_cust_az12;

--check for null Id's
SELECT *
FROM BRONZE.erp_cust_az12
WHERE CID IS NULL;

--check for invalid gender
SELECT DISTINCT GEN
FROM BRONZE.erp_cust_az12;

--=============================================================================
--erp_loc_a101
SELECT *
FROM BRONZE.erp_loc_a101
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.erp_loc_a101;

--check null Id's
SELECT *
FROM BRONZE.erp_loc_a101
WHERE CID IS NULL;

--check distinct counties
SELECT DISTINCT CNTRY
FROM BRONZE.erp_loc_a101;

--=============================================================================
--erp_px_cat_g1v2
SELECT *
FROM BRONZE.erp_px_cat_g1v2
LIMIT 10;

SELECT COUNT(*)
FROM BRONZE.erp_px_cat_g1v2;

--ckeck null Id's
SELECT ID
FROM BRONZE.erp_px_cat_g1v2
WHERE ID IS NULL;

--ckeck distinct categories
SELECT DISTINCT CAT
FROM BRONZE.erp_px_cat_g1v2;

--ckeck distinct subcategories
SELECT DISTINCT CAT,SUBCAT
FROM BRONZE.erp_px_cat_g1v2;

--ckeck for valid maintenance
SELECT DISTINCT MAINTENANCE
FROM BRONZE.erp_px_cat_g1v2;

--=============================================================================




