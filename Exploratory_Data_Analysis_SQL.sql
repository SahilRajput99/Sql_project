-- Exploratory Data Analysis

select *
from layoffs_staging2;

select max(total_laid_off)
from layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were
select max(percentage_laid_off), min(percentage_laid_off)
from layoffs_staging2
where percentage_laid_off is not null;

-- Which companies had 1 which is basically 100 percent of they company laid off

select company, percentage_laid_off
from layoffs_staging2
where percentage_laid_off =1;
-- these are mostly startups it looks like who all went out of business during this time

-- if we order by funds_raised_millions we can see how big some of these companies were
select company, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where percentage_laid_off =1
order by funds_raised_millions desc;
-- BritishVolt looks like an EV company raised like 2 billion dollars and went under - ouch

-- Companies with the biggest single Layoff
select company, total_laid_off
from layoffs_staging2
order by total_laid_off desc
limit  5;
-- now that's just on a single day

-- Companies with the most Total Layoffs
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by sum(total_laid_off) desc
limit  10;

-- by location
select location, sum(total_laid_off)
from layoffs_staging2
group by location
order by sum(total_laid_off) desc
limit  10;

-- this it total in the past 3 years or in the dataset
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1;

select substring(`date`, 6,2), sum(total_laid_off)
from layoffs_staging2
group by substring(`date`, 6,2)
order by 2 desc;

select substring(`date`, 1,7), sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by substring(`date`, 1,7)
order by 2 desc;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 

with  rolling_Total As
(
select substring(`date`, 1,7) as month, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by substring(`date`, 1,7)
order by 2 desc
)
select month, total_off, sum(total_off) over(order by month)
from rolling_total;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

with company_years as
(
select company, year(`date`) as years, sum(total_laid_off) as total_laid
from layoffs_staging2
group by company, year(`date`)
), company_years_rank as 
(select company, years, total_laid, dense_rank() over(partition by years order by total_laid desc) as ranking
from company_years
where years is not null)
select *
from company_years_rank
where ranking <=5;

-- Rolling Total of Layoffs Per Month
select substring(`date`,7,1) as dates, sum(total_laid_off)
from layoffs_staging2
group by dates
order by sum(total_laid_off) asc;

-- now use it in a CTE so we can query off of it

with data_cte as
(
select substring(`date`,7,1) as dates, sum(total_laid_off)  as total_laid
from layoffs_staging2
group by dates
order by total_laid asc
)
select dates, sum(total_laid) over(order by dates asc) as rolling_total_layoffs
from data_cte
order by dates