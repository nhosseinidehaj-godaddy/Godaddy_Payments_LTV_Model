---We will use a table which has all the identified powerseller targets bi.ba_commerce.ps_data_jul_23  and bundle up industries in few major industries aligned with the sic_codes
--- bi.ba_commerce.ps_data_jul_23 has collections of shopper_id with various attributes such as industry , gd products etc . The table also has cohort column which is used to categorize table samples with  model used and accuracy level. Population in cohort 5 is domain only shoppers hence are considerd as low confidence ML model results while rest other cohorts are clubbed together as high confidence ML model

drop table if exists data;
create temp table data as
select a.*,
case when coalesce(sic_major_group,industry,  industry2) = 'FARMING' then 'Agricultural Production - Crops'
       when coalesce(sic_major_group,industry,  industry2) in ('ARBORISTS_LUMBER_TRIMMING','DOG_TRAINING','EQUESTRIAN','HOME_LAWNGARDEN_AND_EQUIPMENT','LANDSCAPING','PET_GROOMING_SERVICES','PET_SITTING','PETS') then 'Agricultural Services'
       when coalesce(sic_major_group,industry,  industry2) in ('AUTO_RACING_MOTORSPORTS','COMPUTER_SOFTWARE_RELATED','ENTERTAINERS_LOCAL','ENTERTAINMENT','FISHING','FITNESS','FITNESS_GYMS','FITNESS_TRAINERS','GOLF_RELATED','LIFESTYLE_ACTIVE','MUSIC_DJ','MUSIC_MUSICIAN_GROUPS','MUSIC_VENUES_CONCERTS','PERFORMING_ARTS_THEATERS','SOCIAL_CLUBS','SPORTS','SPORTS_BASEBALL','SPORTS_BASKETBALL','SPORTS_LOCAL_ATHLETICS','TICKETS_PROMOTIONS','YOGA') then 'Amusement and Recreation Services'
       when coalesce(sic_major_group,industry,  industry2) in ('BOUTIQUE_SHOPS','CHILD_BABY_CLOTHING_ACCESSORIES','CLOTHES_ATHLETIC_GEAR','CLOTHES_TSHIRTS','CLOTHING','CLOTHING_MENS','CLOTHING_SHOES','FASHION_DESIGN','FASHION_STYLE_RELATED','FASHION_WOMENS_CLOTHING') then 'Apparel and Accessory Stores'
       when coalesce(sic_major_group,industry,  industry2) in ('AUTO_DEALERS','AUTO_SALES_ACCESSORIES_INFORMATIONAL') then 'Automotive Dealers and Gasoline Service Stations'
       when coalesce(sic_major_group,industry,  industry2) in ('AUTO_BODY_REPAIR','AUTO_CLEANING_DETAIL_WASH','AUTO_PARTS','AUTO_RELATED','AUTO_REPAIR', 'TOWING_SERVICES') then 'Automotive Repair, Services, and Parking'
       when coalesce(sic_major_group,industry,  industry2) in ('CONSTRUCTION','HOME_CONSTRUCTION_RELATED','HOME_CONTRACTORS') then 'Building Construction General Contractors and Operative Builders'
       when coalesce(sic_major_group,industry,  industry2) in ('ART') then 'Building Materials, Hardware, Garden Supply, and Mobile Home Dealers' 
       when coalesce(sic_major_group,industry,  industry2) in ('ADULT_ENTERTAINMENT','ADVERTISING','AERIAL_DRONE_PHOTOGRAPHY_VIDEOGRAPHY','ARTISTS','AUTO_SALES_SERVICE_ACCESSORIES','BLOGS','BOOKS_AND_BOOK_REVIEWS','BUSINESS_ADVERTISING','BUSINESS_GENERAL','BUSINESS_JANITORIAL_SERVICES','BUSINESS_SERVICES','CARDS_STATIONARY_PLAYING_TRADE','CAREER_COACHING_DEVELOPMENT','CLEANING_SERVICES','COMPUTER_RELATED','COMPUTER_SECURITY','CREDIT_DEBT_SOLUTIONS','CRYPTO_AND_CURRENCY_RELATED','EMPLOYMENT_STAFFING_RECRUITING','EVENTS','FINANCIAL_SERVICES','GAMES','GRAPHIC_DESIGN','HEALTH_CONSULTANT','HOME_CLEANING','HOME_INSPECTION','HOME_INTERIOR_DESIGN','HOME_RELATED','HOME_SERVICES','INFORMATION_LIFESTYLE','INFORMATION_RELATED','INFORMATION_TECHNOLOGY','INTERNET_MARKETING','IT_SERVICES','JOBS_RELATED','MEDIA','MEDIA_ARTS_PODCASTS_TORRENTS','MEDIA_RELATED','MODELS_TALENT','MUSIC_MUSICIANS_INSTRUMENTSTORES','MUSIC_PRODUCTION_SERVICES','NOTARIES','OUTDOOR_GEAR_ACTIVITIES','PARTY_RENTALS','PERSONAL','PERSONAL_ADMIN_ASSISISTANTS','PERSONAL_FAMILY','PERSONAL_PORTFOLIO_SHOWCASE_RELATED','PEST_CONTROL','PHONE_RELATED','PRIVATE_INVESTIGATORS','PROFESSIONAL','PROMOTIONAL_SERVICES','PSYCHIC_ASTROLOGY','PUBLIC_SPEAKING_MOTIVATIONAL','REAL_ESTATE','RETAIL_ECOMMERCE_RELATED','SCIENCE_TECHNOLOGY','SECURITY_SERVICES','SECURITY_SYSTEMS_PRODUCTS','SHOPPING_RELATED','SOFTWARE_APPLICATION_RELATED','VIDEO_GAMES','WEB_DESIGN') then 'Business Services'
       when coalesce(sic_major_group,industry,  industry2) in ('RADIO_AND_PODCASTS','TELECOM_RELATED') then 'Communications'
       when coalesce(sic_major_group,industry,  industry2) in ('ELECTRICAL_ELECTRICIANS','HOME_PAINTERS_AND_SUPPLIES','HOME_REPAIR_AND REMODELING','HOME_ROOFING_COMPANIES','HVAC_PLUMBING_HEATING_RELATED','HVAC_PLUMBING_SERVICES','SOLAR_RELATED') 
       then 'Construction Special Trade Contractors'
       when coalesce(sic_major_group,industry,  industry2) in ('FINANCIAL_SERVICES_BANKS') then 'Depository Institutions'
       when coalesce(sic_major_group,industry,  industry2 ) in  ('COFFEE_TEA','FOOD','FOOD_CHEFS_CATERING','FOOD_DRINK_INFORMATIONAL','FOOD_RELATED','FOOD_TRUCKS','RESTAURANTS','RESTAURANTS_CAFE','RESTAURANTS_PIZZA')
       then 'Eating and Drinking Places'
when coalesce(sic_major_group,industry,  industry2) in ('EDUCATION','EDUCATION_DISABILITIES_HELP','EDUCATION_SCHOOLS','MUSIC','TUTORS') then 'Educational Services'
when coalesce(sic_major_group,industry,  industry2) in ('ARCHITECTS_RELATED','BUSINESS_DEVELOPMENT_SERVICES','BUSINESS_SERVICES_BOOKKEEPING','CONSTRUCTION_MANAGEMENT','EDUCATION_CONSULTANTS_SERVICES','ENERGY_POWER_UTILITY_RELATED','ENGINEERING_RELATED','FINANCE_CONSULTING_INFORMATIONAL','FINANCIAL_INVESTING','GENERAL_BUSINESS_CONSULTING','HUMAN_RESOURCES','MARKETING_RELATED','PUBLIC_RELATIONS_COMMUNICATIONS') then 'Engineering, Accounting, Research, Management, and Related Services'
when coalesce(sic_major_group,industry,  industry2) in ('GOVERNMENT_LOCAL_SERVICES_POLITICS') then 'Executive, Legislative, and General Government, except Finance'
when coalesce(sic_major_group,industry,  industry2) in ('MANUFACTURING') then 'Fabricated Metal Products, except Machinery and Transportation Equipment'
when coalesce(sic_major_group,industry,  industry2) in ('BAKERIES','GROCERY') then 'Food Stores'
when coalesce(sic_major_group,industry,  industry2) in ('DENTIST_ORTHODONTISTS','HEALTH','HEALTH_CARE','HEALTH_WEIGHT_LOSS','HEALTH_WELLNESS','MEDICAL','MEDICAL_ALTERNATIVE','NUTRITIONISTS','PYSCHOLOGY_THERAPY') then 'Health Services'
when coalesce(sic_major_group,industry,  industry2) in ('FURNITURE_SALES_MANUFACTURING',
'HOME_DECOR',
'HOME_FURNISHINGS_CABINETS_STAIRS') then 'Home Furniture, Furnishings, and Equipment Stores'
when coalesce(sic_major_group,industry,  industry2) in ('HOTELS',
'VACATION_RENTALS') then 'Hotels, Rooming Houses, Camps, and other Lodging Places'
when coalesce(sic_major_group,industry,  industry2) in ('INSURANCE') then 'Insurance Agents, Brokers and Service'
when coalesce(sic_major_group,industry,  industry2) in ('VOLUNTEER_ORGANIZATIONS') then 'Justice, Public Order, and Safety'
when coalesce(sic_major_group,industry,  industry2) in ('ACCESSORIES','ANTIQUES_SALVAGE_COLLECTIBLES','ARTS_CRAFTS','BEER_WINE_SPIRITS','BOOKS_STORES','CANDLES_SCENTS','CANNABIS_RELATED','COSMETICS','FLORISTS','FLOWERS','GIFTS','GUNS_KNIVES','JEWELRY','JEWELRY_METALS_GEMS','MOTORCYCLE_MODEL_SCOOTER_RELATED','PET_DOGS_STORE_SERVICES','STORES_CONSIGNMENT_VINTAGE_ANTIQUE','TOBACCO_VAPING_PRODUCTS_SHOPS','TOY_STORES') then 'Miscellaneous Retail'
when coalesce(sic_major_group,industry,  industry2) in ('ADULT_DATING','BARBERS','BEAUTY_HAIR','BEAUTY_RELATED','BEAUTY_SALON_SPA','CARPET_CLEANING','COSMETICS_RELATED','FINANCIAL_TAX_SERVICES_RELATED','HOME_REPAIR','LIFECOACH','MASSAGE','PHOTOGRAPHY','SKIN_CARE_PRODUCTS_INFORMATION','TATTOOS_PIERCING','WEDDING_SERVICES','WEDDINGS_SERVICES_PLANNING') then 'Personal Services'
when coalesce(sic_major_group,industry,  industry2) in ('REAL_ESTATE_AGENTS','REAL_ESTATE_COMMERCIAL','REAL_ESTATE_DEVELOPMENT','REAL_ESTATE_INFORMATIONAL','REAL_ESTATE_SERVICES') then 'Real Estate'
when coalesce(sic_major_group,industry,  industry2) in ('AGRICULTURE_GOODS_SERVICES','BUSINESS_FINANCIAL_TRADE','EXPORTS_IMPORTS_PRODUCTS','FOOD_PRODUCTS','HEALTH_PRODUCTS','HEALTH_PRODUCTS_VITAMINS_SUPPLEMENTS','OIL_PETROLEUM_GAS_INDUSTRIES','WHOLESALE_STORES') then 'Wholesale Trade-Nondurable Goods'
when coalesce(sic_major_group,industry,  industry2) in ('BUSINESS_TRADE','CHARITABLE_ORGANIZATIONS','COMMUNITY_ORGANIZATIONS','COMMUNITY_ORGANIZATIONS_CLUBS','FUNDRAISING_RELATED','NONPROFIT','POLITICS','RELIGION','RELIGION_ORGANIZATIONS','RELIGION_PLACES','VETERANS_CLUBS_CAUSES_RELATED','YOUTH_ORGANIZATIONS') then 'Membership Organizations'
when coalesce(sic_major_group,industry,  industry2) in ('LAWYERS','LEGAL_SERVICES') then 'Legal Services'
when coalesce(sic_major_group,industry,  industry2) in ('TRANSPORTATION_RELATED','TRANSPORTATION_TAXI') then 'Local and Suburban Transit and Interurban Highway Passenger Transportation'
when coalesce(sic_major_group,industry,  industry2) in ('WOODWORKING') then 'Lumber and Wood Products, except Furniture'
when coalesce(sic_major_group,industry,  industry2) in ('HOME_APPLIANCE','LOCKSMITHS','MOBILE_CELLULAR_WIRELESS','REPAIR_SERVICES_ELECTRONICS') then 'Miscellaneous Repair Services'
when coalesce(sic_major_group,industry,  industry2) in ('SIGNAGE_DISPLAY_DESIGN') then 'Miscellaneous Manufacturing Industrie'
when coalesce(sic_major_group,industry,  industry2) in ('VIDEO_FILM_PRODUCTIONS','VIDEO_PRODUCTION_SERVICES') then 'Motion Pictures'
when coalesce(sic_major_group,industry,  industry2) in ('DELIVERY_SERVICES','MOVING_STORAGE','TRANSPORTATION_SHIPPING_TRUCKING') then 'Motor Freight Transportation and Warehousing'
when coalesce(sic_major_group,industry,  industry2) in ('GALLERIES') then 'Museums, Art Galleries, and Botanical and Zoological Gardens'
when coalesce(sic_major_group,industry,  industry2) in ('FINANCIAL_LOANS','MORTGAGE_LENDING') then 'Non-Depository Credit Institutions'
when coalesce(sic_major_group,industry,  industry2) in ('CLOTHES_TSHIRTS_PRINTING_EMBROIDERY','COPY_PRINTING_RELATED','MAGAZINES_NEWSPAPERS_PERIODICALS','PUBLISHING') then 'Printing, Publishing, and Allied Industries'
when coalesce(sic_major_group,industry,  industry2) in ('CHILDCARE_RELATED','COUNSELING_THERAPY') then 'Social Services'
when coalesce(sic_major_group,industry,  industry2) in ('LOGISTICS','TRAVEL','TRAVEL_RELATED') then 'Transportation Services'
when coalesce(sic_major_group,industry,  industry2) in ('ELECTRONICS_RELATED','INDUSTRIAL_RELATED') then 'Wholesale Trade-Durable Goods' 
when industry ilike 'Business Services' then 'Business Services'
when industry = 'Miscellaneous Retail' then 'Miscellaneous Retail'
when industry in  ('Health Services', 'Health/allied services') then 'Health Services'
when industry = 'Personal Services' then 'Personal Services'
when industry = 'Construction Special Trade Contractors' then 'Construction Special Trade Contractors'
when industry = 'Printing, Publishing, and Allied Industries' then 'Printing, Publishing, and Allied Industries'
when industry in  ('Apparel and other Finished Products Made from Fabrics and Similar Materials', 'Apparel and Accessory Stores') then 'Apparel and Accessory Stores'
when industry = 'Hotels, Rooming Houses, Camps, and other Lodging Places' then 'Hotels, Rooming Houses, Camps, and other Lodging Places'
when industry ilike 'eating place' or industry = 'Drinking place' or industry = 'Eating and Drinking Places' then 'Eating and Drinking Places'
when industry = 'Home Furniture, Furnishings, and Equipment Stores' then 'Home Furniture, Furnishings, and Equipment Stores'
when industry = 'Automotive Repair, Services, and Parking' then 'Automotive Repair, Services, and Parking'
when industry ilike  '%Dentist%' or industry ilike '%Chiropractor%' or industry ilike '%Health%' then 'Health Services'
when industry = 'Agricultural Services' then 'Agricultural Services'
else 'Other' end as Industry3
from bi.ba_commerce.ps_data_jul_23  a;

---using naics test results we will assigned industry specific avg GPV for all identified powersellers at shopper_id level
-- we will assign model accuracy of 0.4 for cohort 5 aka (low confidence ML model) while all other cohort will be assigned accuracy of 0.7 as they all collectively form high confidence ML model
--- we will add the propensity model score at shopper_id level as per the latest model run 

drop table if exists GDP_pLTV_driver;
create temp table GDP_pLTV_driver as
select a.shopper_id,
case when cohort = 'Cohort 5' then 0.4 else 0.7 end as model_accuracy,
case when Industry3 =  'Wholesale Trade-Durable Goods' then 688970
    when Industry3 =  'Automotive Dealers and Gasoline Service Stations' then 582354
    when Industry3 =  'Miscellaneous Retail' then 563023
    when Industry3 =  'Wholesale Trade-Nondurable Goods' then 562972
    when Industry3 =  'Home Furniture, Furnishings, and Equipment Stores' then 562109
    when Industry3 =  'Food Stores' then 521020
    when Industry3 =  'Construction Special Trade Contractors' then 519039
    when Industry3 =  'Business Services' then 499215
    when Industry3 =  'Automotive Repair, Services, and Parking' then 493595
    when Industry3 =  'Miscellaneous Repair Services' then 482881
    when Industry3 =  'Health Services' then 479809
    when Industry3 =  'Agricultural Services' then 426638
    when Industry3 =  'Hotels, Rooming Houses, Camps, and other Lodging Places' then 417060
    when Industry3 =  'Legal Services' then 405106
    when Industry3 =  'Eating and Drinking Places' then 390949
    when Industry3 =  'Engineering, Accounting, Research, Management, and Related Services' then 373439
    when Industry3 =  'Amusement and Recreation Services' then 357471
    when Industry3 =  'Membership Organizations' then 330614
    when Industry3 =  'Apparel and Accessory Stores' then 266533
    when Industry3 =  'Personal Services' then 258216
    else 250000 end as Avg_GPV,
case when b.model_prediction_score is not null then b.model_prediction_score else 0 end as Propensity_score , 
b.partition_prediction_run_pst_date as Model_prediction_date,
 Industry3
from data a 
left join bi.ml_batch_predictions_cln_spectrum.customer_gd_payment_propensity_prediction_history_cln b
on a.shopper_id = b.shopper_id
and partition_prediction_run_pst_date in (select max(partition_prediction_run_pst_date) 
                                          from bi.ml_batch_predictions_cln_spectrum.customer_gd_payment_propensity_prediction_history_cln)
;

---using propensity model backtesting results for sales leads we assigned probabilty of conversion based on model deciles.

--Decile propensity_score
--0    0.000000e+00
--1    1.033494e-28
--2    1.953547e-16
--3    5.479919e-12
--4    1.294813e-09
--5    8.342035e-08
--6    2.880347e-06
--7    6.446732e-05
--8    6.358081e-04
--9    3.766050e-03

drop table if exists GDP_pLTV_driver2;
create temp table GDP_pLTV_driver2 as
select *,
case when Propensity_score > 0.003766050 then 0.35
     when Propensity_score > 0.0006358081 then 0.25
     when Propensity_score > 0.00006446732 then 0.15
     when Propensity_score > 0.000002880347 then 0.15
     when Propensity_score > 0.00000008342035 then 0.05
     when Propensity_score > 0.000000001294813 then 0.002
     when Propensity_score > 0.000000000005479919 then 0.0001
     else 0.0001 end as Prob_to_apply
from GDP_pLTV_driver;

--- we wrote all this data as GDP_pLTV_old as till here all the calculation is done for existing shopper_id as of July 2023
-- finally the GD LTV is calculated using formula (Avg_GPV * Prob_to_apply * model_accuracy * 0.0254 * 3)

drop table if exists GDP_pLTV_old;
create temp table GDP_pLTV_old as
select shopper_id, Industry3,
(Avg_GPV * Prob_to_apply * model_accuracy * 0.0254 * 3) as pLTV_old
from GDP_pLTV_driver2
;

-- As many new shoppers come to godaddy and apply for GD payments we used GCR as indication of powersellers. Any shopper who has GD payment propensity score in decile 9 (highest decile) and has GCR >$1000 USD but less than $30000 USD (this is done to remove investors) will be considered as PS with GPV potential of $100k (this is inline with Sales calculator used today in GD Payments)
--Any shopper who has GD payment propensity score in decile 9 (highest decile) and has GCR <$1000 USD will be considered as Micromerchant with GPV potential of $10k (this is inline with Sales calculator used today in GD Payments)
-- Any shopper for whom we do not have propensity score we will consider them to have $10k potential with 0.1% conversion chance (business approximation used)
---rest will be considered as $0 for GD LTV



drop table if exists GDP_pLTV_new;
create temp table GDP_pLTV_new as
select distinct a.shopper_id , total_gcr_usd_amt,
case when (b.model_prediction_score > 0.003766050 and total_gcr_usd_amt > 1000 and total_gcr_usd_amt < 30000 )then (0.25 * 3 * 100000 * 0.0254)
    when (b.model_prediction_score > 0.003766050 and total_gcr_usd_amt < 1000  )then (0.25 * 3 * 10000 * 0.0254)
     when b.model_prediction_score is null then (0.001 * 3 * 10000 * 0.0254)
     else 0 end as GDP_pLTV_new , 
b.partition_prediction_run_pst_date as Model_prediction_date
from bi.dna_approved.shopper_360_current a 
left join bi.ml_batch_predictions_cln_spectrum.customer_gd_payment_propensity_prediction_history_cln b
on a.shopper_id = b.shopper_id
and partition_prediction_run_pst_date in (select max(partition_prediction_run_pst_date) 
                                          from bi.ml_batch_predictions_cln_spectrum.customer_gd_payment_propensity_prediction_history_cln)
where acq_report_region_2_name = 'United States' 
and a.shopper_status = 'Active' ;


-- both the LTV for new and old shoppers are added and written in a single table bi.ba_commerce.GDP_pLTV which will be used for all analytical purposes

drop table if exists bi.ba_commerce.GDP_pLTV;
create  table bi.ba_commerce.GDP_pLTV as
select a.shopper_id,
case when pLTV_old > 0 then pLTV_old else GDP_pLTV_new  end as pLTV,
b.Industry3 as Industry,
a.total_gcr_usd_amt as Lifetime_GCR 
from GDP_pLTV_new a 
left join  GDP_pLTV_old b 
on a.shopper_id = b.shopper_id;