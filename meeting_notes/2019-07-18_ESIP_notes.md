# 2019-07-18 - ESIP notes

Phase 1: climdb > cuahsi

What EDI will do

1. Archive climdb as a DB dump. 
    1. 1 data package in EDI holding the text-dump (otherEntity)
1. Export climdb content to ODM format to prepare it for CUASHI
    1. As EML data packages in EDI
    1. Tbd:
        1. Exact packaging scheme (anticipating 1/climdb-contributor, eg, lter site)
        2. Mechanism for requesting needed metadata
        3. Aggregation level (anticipating hourly)
1. Coordinate with CUAHSI to accept these 
    1. Timing, ownership, volume

----------------

## Don - intro to Climdb

Climdb has 
- 26 LTERs - (24 us + 2 international)
- 22 USFS

## Martin - intro to CUAHSI

- Hydroshare = file based,
- HIS = time-series based.
- Look at his architecture slide, very general (good for overviews)

ODM 1.1 ERD (I think you lost your copy)

**We would use HIS**

The process for updating in HIS is very similar to GBIF - I think (although it sounds like HIS disallows duplicates - how do they detect duplicate? Is it only dateTime-station-measurementName? Or do they check values? How are values replaced?)


Process for someone who is a current climdb contributor:

1. Deposit L0 is in EDI, in your format and resolution
2. Deposit L1 in EDI, in ODM format and recommended resolution


## Corinna’s demo/tour of ODM files

[https://github.com/lter/Clim-HydroDB-2.0](https://github.com/lter/Clim-HydroDB-2.0)

Misc: 

- Cuahsi uploads need to be chunked up, 500,000 record limit per upload.
- We might need some advice on handling a few of the vocab terms - eg, “medium name”,
- “General category”, we might need some recommendations - are these collection context or use-context?


# Action items

## TO DO (EDI): 

- Write up a generic pathway. E.g., L0 > L1 > external-query-sys (e.g., cuahsi, gbif), ie, Data goinh from L1 to an external-query-system via a harvester.
- EDI is not committing to writing the harvesters - at least not for now. EDI can mediate contributions to CUAHSI. We do not yet know whether this will have manual steps or could be automated via a harvester. EDI is not committing to a harvester at this time.

## Webinars to plan

1. ODM format itself
    1. CUASHI system is optimized for querying the data values themselves, so some metadata is in tables, rather than in EML.
        1. Observation table is Long format (rather than wide), that links to metadata in other tables
        2. Entity-specific metadata is in tables (so they can be queried)
        3. High-level metadata in EML.
2. Making ODM packages
    2. With R
    3. With GCE-toolbox
3. Submissions to CUAHSI
    4. Org-logins
    5. How to? Are these manual processes or with an API?
    6. Size limits & Chunking up
4. Best ways/Options for streaming data  (guest - Collin Bode, Eel River CZO/UCB)
    7. E.g. a branched workflow with streaming data that goes directly into CUAHSI, 
    8. with cached-version in a permanent archive.

## Outline Intro materials

we will need, e.g.,

## Outreach to data users -

   1. How to get data from CUAHSI (manual, or hydroclient)

   2. How to use CUAHSI web services, for lightweight applications (guest speaker: Emilio Mayorga - he will be at NCEAS in October)

## Questions/discussions:

Climdb had pretty regular harvests. Does EDI anticipate we would contribute at that freq? Eg. weekly?

A: don’t know yet. - any kind of harvesting is TBD- not committing till we know more about how it works

Colin Bode CZO/berkeley - please upload the highest resolution that Martin will let you. Aggregating is easy, downsampling isnt (or is impossible)

Collin Bode CZO/berkeley - Methods text can be a URL. Manufactures stat page is very useful. name of the method = name of piece of equipment is the, with spec page.

Encourage people to have a branched workflow - that their streaming data goes directly into CUAHSI, rather than (if data are streaming) pushing the cached-version into HIS.

Collin Bode does not like ODM2. it tries to do too much - handle everything. But one-system-to-hold it all is just beyond the rainbow.

Ask for his model, please [based on controlled vocabs)

3 orgs use his system - vocabs they understand. 

Dependent on concepts of site, data stream


<!-- Docs to Markdown version 1.0β17 -->
