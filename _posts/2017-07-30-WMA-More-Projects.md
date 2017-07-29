---
layout: post
title: "Another Project Idea!"
tags:
- teaching
- moneyball
- projects
- mini-project
---

Here is another project idea in addition to ones you've already seen.

### Turning Lecture 3 into a mini-project!

(1) In lecture 3, we BA standardized BA by season so that we could compare players from different eras. Try this with different statistics. You can even create your own. You can use the baseball dataset we have been working with or if you want to work with a different sport try one of these datasets:
    - [NBA Boxscores Dataset](../../../assets/moneyball/nba_boxscore_with_position.csv) for the 1996/7 - 2015/16 seasons.
    - [NHL Boxscores Dataset](../../../assets/moneyball/nhl_boxscores.csv) for the 2005/6 - 2015/16 seasons.
    - [NFL Boxscores Dataset](../../../assets/moneyball/nfl_boxscores.csv) for the 2005/6 - 2015/16 seasons.
    
    Like before, you probably want to subset on players who have played some minimum number of games, taken a minimum number of shots, or some other eligibility criteria. Also, for the NFL and NBA data the statistics will be position specific so you'll want to consider a specifc position or set of positions (e.g. WR and TE or all defensive backfield positions).
(2) Build a histogram of the standardized statistic you created for a particular season (choose your favorite). Does the empirical rule apply? Are there any players who stand out?
(3) Can you make some interesting plots?

### Turning the mini-project into your end-of-camp project

For the projects you'll work on next week, you can expand on your mini-project in one of several directions. For instance:

(1) How does a recent player compare to a player from an early season?
(2) How does a particular player's standardize performance track over the time frame we're considering? 
(3) Can you recreate this analysis for different positions? 
    - Are there differences in the time trends between positions over time? 
    - Is the statistic you are analyzing more volatile for different positions? 
    - Have certain positions seen changes in the volatility of the statistic over time?
(4) Compare two players who played different positions using the standarized scores where you don't split by position and the scores when you do.
  - Do you get different conclusions? Does one comparison make more sense?
(5) Make some informative plots! For example, plot the mean of your statistic over seasons with lines to indicated +/- 2 SDs. Can you figure out how to plot points for the players in each season who don't fall inside the +/- 2 SD "band"? Can you label them?