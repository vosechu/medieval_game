# Possible Milestones

0.1 * one village object, runs alone, but does things to keep itself going. Plants crops, harvests, celebrates. This will allow us to calibrate basic happiness values; town should be quite pleased. No entropy generators. Basic KPIs for happiness. 
0.1.1 * load up 10k villages, 500k agents and see how long a tick takes. We would like it to be capable of 30ticks per second. Now decide whether we can have individual agents or need to use towns as the agents. At 3ticks per second it would take 16 hours to run through 500 years. 
0.2 * Add in an economic sink village which has too many people for the resources it produces, but has wealth to pay for farm goods. Goods may not be available at town when needed. There is some tick delay between sink village and source village. Add in basic economic KPIs
0.2.1 * Add in a second source village, how does the sink village choose between the two? Allow the sink to grow unbounded until equilibrium. 
0.3 * Add in event generators to see how the villages respond. Add in basic health KPIs. 
0.4 * Add in minerals, natural resources, technology to process. Secondary markets, communication delays and market pricing. Wealth KPIs (total and per capita)
0.5 * Add in government decision making, rollup KPIs and 4 pillar GNH. 
0.6 * Territory ownership and conquering/transfer of ownership, taxation. 9 item GNH.
...
0.8 * Weather permanently enabled
0.9 * Advanced economics, futures, planning. GDP/GPI KPIs
1.0 * Exit modeling phase, make a game now that we have realistic and viable numbers. Proof of concept. 

Other things
* Tech tree
* 100% Causal event generators, no fixed event generators left
* Castle building, battle, military units, tech tree entries. Generals and armies. Combat AI. 
* Policy and laws

## Outdated idea

Possible versions
* v1: a land mass, with a single village which is about at half capacity. Farms get plowed, sheep get sheared. Town automatically responds to external stimuli in a reasonable, self-preserving way. No interaction from the player yet except throwing events at the town. Town should show some resilience, it should be difficult to ghost a village entirely, so over the years we would expect it to hit max capacity. Since there's no export, villages should not stockpile secondary/produced goods (wool, clothes, timber) more than what they might need for the year. 
* v2: same land mass, add in another village and the mechanic of needing tools. Vary the location of an iron mine, and a blacksmith, see the villages trading with each other as needs arise. Villages should try to stay close to the black, so we shouldn't see too much of a stockpile if the demand seems to be low (because the other village is satisfied). Add in 3 more villages so the demand is higher, and see the village with the mine and the village with the blacksmith grow significantly faster. Add some arable land between the villages and watch it get claimed, but no fighting yet

## More outdated

Priorities
* fixed map > randomized map > randomized full-sized world 
