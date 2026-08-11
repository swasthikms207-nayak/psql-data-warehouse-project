/*
========================================================================================
Procedure : Create Gold Views

Purpose   : Create business-ready views in the Gold layer by integrating and
            transforming Silver-layer data into a dimensional model for
            reporting and analytical purposes.

========================================================================================
*/

--dim_customers

CREATE VIEW GOLD.dim_customers AS
SELECT
ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
c.cst_id AS customer_id,
c.cst_key AS customer_number,
c.cst_firstname AS first_name,
c.cst_lastname AS last_name,
cb.CNTRY AS country,
c.cst_marital_status AS marital_status,
CASE WHEN c.cst_gndr!='n/a' THEN cst_gndr
     ELSE COALESCE(ca.GEN,'n/a')
END AS gender,
ca.BDATE AS birth_date,
c.cst_create_date AS create_date
FROM SILVER.crm_cust_info c
LEFT JOIN SILVER.erp_cust_az12 ca
ON ca.CID=c.cst_key
LEFT JOIN SILVER.erp_loc_a101 cb
ON cb.CID=c.cst_key;
--===========================================================================================

--dim_products

CREATE VIEW GOLD.dim_products AS
SELECT
ROW_NUMBER() OVER(ORDER BY p.prd_id,p.prd_start_dt) AS product_key,
p.prd_id AS product_id,
p.prd_key AS product_number,
p.prd_nm AS product_name,
p.cat_id AS category_id,
p1.CAT AS category,
p1.SUBCAT AS subcategory,
p1.MAINTENANCE AS maintenance,
p.prd_cost AS product_cost,
p.prd_line AS product_line,
p.prd_start_dt AS product_start_date,
p.prd_end_dt AS product_end_date
FROM SILVER.crm_prd_info p
LEFT JOIN SILVER.erp_px_cat_g1v2 p1
ON p1.ID=p.cat_id;
--===========================================================================================

--fact_sales

CREATE VIEW GOLD.fact_sales AS
SELECT
s.sls_ord_num AS order_number,
p.product_key AS product_key,
c.customer_key AS customer_key,
s.sls_order_dt AS order_date,
s.sls_ship_dt AS ship_date,
s.sls_due_dt AS due_date,
s.sls_sales AS sales_amount,
s.sls_quantity AS quantity,
s.sls_price AS price
FROM SILVER.crm_sales_details s
LEFT JOIN GOLD.dim_products p
ON p.product_number=s.sls_prd_key
LEFT JOIN GOLD.dim_customers c
ON c.customer_id=s.sls_cust_id;
--===========================================================================================





