The GoDaddy payment Lifetime Value (LTV) model has been designed to prioritize shopper_ids by assessing their potential to generate Gross Contribution Revenue (GCR) for the GoDaddy payment business. Given that GD Payment is a recent addition to GoDaddy's product offerings, there are data limitations for constructing a precise Predictive LTV (pLTV) model. To address this challenge, we devised a framework centered around the central limit theorem, leveraging a variety of machine learning models developed specifically for GD Payment throughout the years 2022 and 2023. 

 

While the model does furnish LTV values at the individual shopper_id level, it is recommended to interpret the results only when the count of Shopper_ids is greater than 100 at a group level. 

The development of the model involved utilizing a comprehensive NAICS dataset comprising 85,000 powersellers. The validation process included scrutiny of each component model and backtesting against sales figures, aligning with both general market trends and the GD payment portfolio. 

 

Models used in the GoDaddy Payment LTV model 

Industry Classification ML Model 

PowerSeller Identification ML Model 

GD Payments Propensity Model 

 

 

**GDP LTV =     PS Avg Sales for Industry  

          x PS Identification Probability  

          x Probability to convert  

          x Take Rate 

          x Avg customer duration** 

 

 

**PS Avg Sales for Industry:** Based on NAICS test results avg GPV for key industries (for GD Payments ) was computed. Industry classification model and Data Provider is used to assign industry at shopper_id. Once an industry is assigned to a shopper_id, the GPV potential for that shopper_id is considered as the average GPV of the corresponding industry. It's important to note that this result is static and remains unchanged over time. 

 

**PS Identification Probability:** a range of machine learning models was employed to compile a list of powersellers within the GoDaddy base. These models fall into two categories 

 

High confidence Model:  PowerSeller Shopper_ids who have GD domains and these domains are attached to a website which we can scrub via Data Provider 

Low confidence Model: PowerSeller Shopper_ids who have GD domains and these domains are not attached to a website which we can scrub via Data Provider 

 

A shopper_id scored by high confidence ML model is assumed to have 70% PS Identification Probability 

A shopper_id scored by low confidence ML model is assumed to have 40% PS Identification Probability 

 

This outcome remains relatively stable and undergoes minimal changes over time. 

 

**Probability to convert:** A probability value was assigned to each shopper_id based on the propensity model decile and the backtesting results for sales leads. This numerical probability signifies the likelihood of a shopper_id converting into a GoDaddy Payment customer when targeted through a Go-To-Market (GTM) motion. 

 

This result is dynamic and will change weekly. 

 

New to GoDaddy Shoppers 

For the merchants who were too new for our ML models we will use GCR as PowerSeller identification 

Shoppers with GCR <$1000 and in highest decile of propensity to convert will be assumed to be a micromerchant with GPV potential of $10k 

Shoppers with GCR >$1000 and in highest decile of propensity to convert will be assumed to be a PowerSellers with GPV potential of $100k 

Rest will be considered as $0 GPV potential  

 

 

**Take Rate:**  the conversion rate for GPV to GCR based on GD Payment portfolio mix as of H1 2023, this was 2.54% 

 

This outcome remains relatively stable and undergoes minimal changes over time. 

 

**Avg customer duration:** Avg customer lifespan with GoDaddy Payments. This is assumed as 3 years. 

 

This outcome remains relatively stable and undergoes minimal changes over time. 

 

 

**Results and Back Testing:** 

 

The model underwent backtesting on the complete transactional portfolio of GD Payments and was also validated for sales leads.  

 

Model results are populated and stored in **bi.ba_commerce.GDP_pLTV** 


[This is the complete description with all model artifacts link to it](https://secureservernet-my.sharepoint.com/:w:/g/personal/sgupta1_godaddy_com/EZ0qi1pIychNoJa1_aRPZWIBJ5RW4kITi5vagLTh2Ggf8A?e=Kh4ERM)


[This is the deck for the LTV model](https://secureservernet-my.sharepoint.com/:p:/g/personal/sgupta1_godaddy_com/EUIw88kKKNBEqSwumC0L2zMBJVgRKI87yqUHv4BmquuACA?e=sxqU49)