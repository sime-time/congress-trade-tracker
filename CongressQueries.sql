-- 1 -- find the politicians in the agricultural committee
select pol_fname, pol_lname, party_id, state_abv, cmt_name 
from Politician p 
inner join Assignment a on a.pol_id = p.pol_id 
inner join Committee c on c.cmt_id = a.cmt_id
where c.cmt_name = 'Agriculture'

-- 2 -- find the active senators in congress
select pol_fname, pol_lname, party_id, state_abv, pol_term_start, pol_term_end
from Senator s 
inner join Politician p on p.pol_id = s.pol_id 
where p.pol_term_end IS NULL

-- 3 -- find minimum to maximum volume of buys and sells for microsoft 
select asset_ticker, trd_type, SUM(rng_min) as MinimumPossibleVolume, SUM(rng_max) as MaximumPossibleVolume
from Trade t
inner join Asset a on a.asset_id = t.asset_id
inner join TradeRange r on r.rng_id = t.rng_id
where a.asset_ticker like 'MSFT'
group by trd_type, asset_ticker

-- 4 -- find the politicians who traded the most volume of Apple stocks
select pol_fname, pol_lname, party_id, asset_ticker, SUM(rng_min) as MinimumVolume$
from Politician p 
inner join Trade t on t.pol_id = p.pol_id 
inner join Asset a on a.asset_id = t.asset_id
inner join TradeRange r on r.rng_id = t.rng_id
group by pol_fname, pol_lname, party_id, asset_ticker
having a.asset_ticker like 'AAPL'
order by SUM(rng_min) desc 

-- 5 -- find the minimum absolute amount volume traded for politician Nancy Polosi 
select pol_fname, pol_lname, party_id, asset_ticker, SUM(r.rng_min) as MinimumTradeVolume
from Politician p 
inner join Trade t on t.pol_id = p.pol_id 
inner join Asset a on a.asset_id = t.asset_id
inner join TradeRange r on r.rng_id = t.rng_id 
group by pol_fname, pol_lname, party_id, asset_ticker 
having p.pol_fname = 'Nancy' and p.pol_lname = 'Pelosi'
order by SUM(r.rng_min) desc 

-- 6 -- find out which type of account owner is used the most 
select trd_owner, count(*) as TotalTrades
from Trade 
group by trd_owner 
order by count(*) desc 

-- 7 -- get all the unique report documents from a single politician, Nancy Pelosi 
select distinct pol_fname, pol_lname, r.report_url, r.report_date
from Politician p 
inner join Trade t on t.pol_id = p.pol_id 
inner join Report r on r.report_id = t.report_id 
where pol_fname = 'Nancy' and pol_lname = 'Pelosi'

-- 8 -- order the political parties by minimum trade volume 
select pty.party_name, SUM(rng_min) as MinimumPossibleVolume$, COUNT(trd_id) as TotalTrades
from Party pty 
left join Politician p on p.party_id = pty.party_id 
left join Trade t on t.pol_id = p.pol_id 
left join Asset a on a.asset_id = t.asset_id
left join TradeRange r on r.rng_id = t.rng_id 
group by pty.party_name
order by SUM(rng_min) desc 


-- 9 -- find the politicians that are in more than 1 committee 
-- (should only be one person because of my limited committee assignment data)
select p.pol_fname, p.pol_lname, count(*) NumOfAssignments
from Politician p 
inner join Assignment a on a.pol_id = p.pol_id 
inner join Committee c on c.cmt_id = a.cmt_id 
group by p.pol_id, p.pol_fname, p.pol_lname
having Count(*) > 1

-- 10 -- find the current stock net profit of each politician by minimum volume 
WITH Buys AS (
    select p.pol_id, p.pol_fname, p.pol_lname, p.party_id, SUM(rng_min) as MinAmount
    from Politician p 
    inner join Trade t on t.pol_id = p.pol_id 
    inner join TradeRange r on r.rng_id = t.rng_id 
    where t.trd_type = 'BUY'
    group by p.pol_id, p.pol_fname, p.pol_lname, p.party_id
), 
Sells AS (
    select p.pol_id, p.pol_fname, p.pol_lname, p.party_id, SUM(rng_min) as MinAmount
    from Politician p 
    inner join Trade t on t.pol_id = p.pol_id 
    inner join TradeRange r on r.rng_id = t.rng_id 
    where t.trd_type = 'SELL'
    group by p.pol_id, p.pol_fname, p.pol_lname, p.party_id
)
select b.pol_id, b.pol_fname, b.pol_lname, b.party_id, (b.MinAmount - s.MinAmount) as CurrentMinAmount
from Buys b 
left join Sells s on b.pol_id = s.pol_id 
order by  (b.MinAmount - s.MinAmount) desc 

select count(*) as politicians from Politician;
select count(*) as trades from Trade;