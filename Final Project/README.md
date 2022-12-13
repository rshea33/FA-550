## Proposal: 15/15




### Part 1: Data Collection

I first picked Jacob DeGrom as the candidate for the slider as his is one of the best in the game. The metrics all came from the 2022 season so they are up to date and use the best data collection tools avalable.

In order to label the data as to whether or not it was executed I went to the website [Baseball Savant](https://baseballsavant.mlb.com/statcast_search?hfPT=SL%7C&hfAB=&hfGT=R%7C&hfPR=&hfZ=&hfStadium=&hfBBL=&hfNewZones=&hfPull=&hfC=&hfSea=2022%7C&hfSit=&player_type=pitcher&hfOuts=&hfOpponent=&pitcher_throws=&batter_stands=&hfSA=&game_date_gt=&game_date_lt=&hfMo=&hfTeam=&home_road=&hfRO=&position=&hfInfield=&hfOutfield=&hfInn=&hfBBT=&hfFlag=&pitchers_lookup%5B%5D=594798&metric_1=&group_by=name&min_pitches=0&min_results=0&min_pas=0&sort_col=pitches&player_event_sort=api_p_release_speed&sort_order=desc#results), as it has a video for each pitch throughout the database. I then manually determined whether or not it was a good/executed pitch in the csv file itself. I did this for roughly ~370 pitches total which I feel will be enough data in order to train the model. I know this is a low amount but as I was going through the pitches I felt like I was developing my own algorithm (first, I'd check the count, then the outs, then the situation, etc.). The GBDTs should learn the same thought process I was thinking.As long as I get decent test accuracy I can use this model to label a *lot* more data, so long as I create an efficient data pipeline.