# README

There are 2 tables, 1 for storing all the data search terms that come in, And one which only stores the final term which is available in the auto complete field. There is a rake task which runs every 10 min for now, To read from Table 1 and Insert unique entries into Table 2. Once inserted the record is deleted in table 1 to ensure it does not expand exponentially. Ideally table 1 would be replaced with a high speed system maybe like REDIS.

Insertions in table 2 are made only if record is created before last 10 min or is in completed state. If a user hits Submit, Its state is saved as completed. If a user does not hit save and leaves in the middle it will use the 10 min window logic to get the record into table 2. 

Insertions in table 1 happen on the base of a unique key which is generated on the front-end. Every time the user removes all the search term or refreshes the page. A new key is generated and associated. This way we only update 1 row in table 1 while he is typing. 

3rd Party JS and CSS Library can be found in lib/assets/javascripts and lib/assets/stylesheets respectively. 


