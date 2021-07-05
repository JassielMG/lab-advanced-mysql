CREATE TEMPORARY TABLE TOTAL(
SELECT 
USE publications

SELECT ti.title_id as 'TITLE_ID', au.au_ID as 'AUTHOR_ID', (ti.price * sale.qty * ti.royalty / 100 * ta.royaltyper / 100) AS 'Royalty' 
FROM authors as au 
LEFT JOIN titleauthor AS ta ON ta.au_id = au.au_id 
INNER JOIN titles as ti ON ti.title_id = ta.title_id
INNER JOIN sales as sale ON sale.title_id = ti.title_id 
GROUP BY au.au_id
ORDER BY Royalty 
DESC LIMIT 3; 
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
*****************************************************************************************************+
CREATE TEMPORARY TABLE sales_royalty(
SELECT ti.title_id as 'TITLE_ID', au.au_ID as 'AUTHOR_ID', (ti.price * sale.qty * ti.royalty / 100 * ta.royaltyper / 100) AS 'Royalty' 
FROM authors as au 
LEFT JOIN titleauthor AS ta ON ta.au_id = au.au_id 
INNER JOIN titles as ti ON ti.title_id = ta.title_id
INNER JOIN sales as sale ON sale.title_id = ti.title_id 
GROUP BY au.au_id
ORDER BY Royalty );

*****************************************************************************************************
SELECT TITLE_ID,AUTHOR_ID,SUM(Royalty) AS 'TOTAL_ROYALTY'
FROM sales_royalty
GROUP BY TITLE_ID, AUTHOR_ID
ORDER BY TOTAL_ROYALTY
*********************************************************************************************

CREATE TEMPORARY TABLE TOTAL(
SELECT 
TITLE_ID,
AUTHOR_ID,
SUM(Royalty) AS 'TOTAL_ROYALTY'
FROM sales_royalty
GROUP BY TITLE_ID, AUTHOR_ID
ORDER BY TOTAL_ROYALTY
);

SELECT TOTAL.AUTHOR_ID,(TOTAL_ROYALTY + advance)
FROM TOTAL
LEFT JOIN titles ON TOTAL.TITLE_ID = titles.title_id 

**************************************************************************************************
/* CHALLENGE 2 */

SELECT TOTAL.AUTHOR_ID as author_id,(TOTAL_ROYALTY + advance) as profits
FROM (
SELECT 
TITLE_ID,
AUTHOR_ID,
SUM(Royalty) AS 'TOTAL_ROYALTY'
FROM sales_royalty
GROUP BY TITLE_ID, AUTHOR_ID
ORDER BY TOTAL_ROYALTY
) as TOTAL
LEFT JOIN titles ON TOTAL.TITLE_ID = titles.title_id 


**************************************************************************************************************
/* CHALLENGE 3 */
CREATE TABLE most_profiting_authors(
SELECT TOTAL.AUTHOR_ID as author_id,(TOTAL_ROYALTY + advance) as profits
FROM (
SELECT 
TITLE_ID,
AUTHOR_ID,
SUM(Royalty) AS 'TOTAL_ROYALTY'
FROM sales_royalty
GROUP BY TITLE_ID, AUTHOR_ID
ORDER BY TOTAL_ROYALTY
) as TOTAL
LEFT JOIN titles ON TOTAL.TITLE_ID = titles.title_id );

SELECT * FROM publications.most_profiting_authors


