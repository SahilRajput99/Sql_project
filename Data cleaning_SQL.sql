-- Data Cleaning


Select * 
FROM layoffs;

-- 1 Remove Duplicates
-- 2 Standardize the Data
-- 3 Null Values or Blank Values
-- 4. Remove Any columns;


CREATE TABLE layoffs_staging
LIKE layoffs;

Select * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

Select * 
FROM layoffs_staging;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoffs_staging;

with duplicate_cte as
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'Cazoo';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoffs_staging;

select *
from layoffs_staging2
where row_num > 1;

Delete 
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;

-- Standardizing the Data

SELECT Distinct(company), trim(company)
from layoffs_staging2;

UPDATE layoffs_staging2
SET company = trim(Company);

SELECT Distinct(industry)
from layoffs_staging2
order by 1;

SELECT industry
from layoffs_staging2
where industry like 'crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry like 'crypto%';

SELECT Distinct(location)
from layoffs_staging2
order by 1;

SELECT Distinct(country)
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where country like 'United States%'
order by 1;

select Distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y' )
from layoffs_staging2;

UPDATE layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y' );

Alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2
where total_laid_off is null
And percentage_laid_off is null;

select  *
from layoffs_staging2
where industry is null
or industry = '';

select  *
from layoffs_staging2
where company = 'Airbnb';

Update layoffs_staging2
set industry = null
where industry = '';

select st1.industry, st2.industry
from layoffs_staging2 st2
join layoffs_staging2 st1
	on st1.company = st2.company
	and st1.location = st2.location
where (st1.industry is null or st1.industry = '')
and st2.industry is not null;

update layoffs_staging2 st1
join layoffs_staging2 st2
	on st1.company = st2.company
set st1.industry = st2.industry
where st1.industry is null
and st2.industry is not null;

select  *
from layoffs_staging2
where company like 'Bally%';

select  *
from layoffs_staging2;

select *
from layoffs_staging2
where total_laid_off is null
And percentage_laid_off is null;

Delete
from layoffs_staging2
where total_laid_off is null
And percentage_laid_off is null;

Alter table layoffs_staging2
drop column row_num;

select  *
from layoffs_staging2;