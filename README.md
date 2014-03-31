<a href='https://gemnasium.com/pfadipatria/hitobito_patria'><img src="https://gemnasium.com/pfadipatria/hitobito_patria.svg" alt="Dependency Status" /></a>

﻿#Hitobito Patria
Hitobito Patria is an Extension for the core hitobito and the hitobito_pbs wagon, reflecting the structures of the swiss scout group "Pfadicorps Patria Bern", as well as some further functionalities.

##New Features and Functionalities
Please document what you did (and why) to accomplish a feature

###Age Group Statistics (Jahrgangsstatistik)
Goal of the age group stats is to evaluate for an "Abteilung" how many many members of a given age group it has. For this the statistics of the PBS-wagon can be extended. When a new data set is being calculated the age group statistics should be counted as well and then stored to the database.

**Changes**

- `AgeGroup` model saves the count of female and male members of an "Abteilung" and an age group
- module `Patria::MemberCounter` to extend the method `count` of `MemberCounter` to calculate the members of an age group
- module `Patria::MemberCount` to extend `MemberCount` model with `has_many AgeGroups` relations

**Interesting Links**

- [Explanation of extending methods of other classes](https://www.ruby-forum.com/topic/128131)
