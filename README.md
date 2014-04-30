[![Dependency Status](https://gemnasium.com/pfadipatria/hitobito_patria.svg)](https://gemnasium.com/pfadipatria/hitobito_patria)

#Hitobito Patria
Hitobito Patria is an Extension for the core hitobito and the hitobito_pbs wagon, reflecting the structures of the swiss scout group "Pfadicorps Patria Bern", as well as some further functionalities.

##New Features and Functionalities
Please document what you did (and why) to accomplish a feature

###Age Group Statistics (Jahrgangsstatistik)
Goal of the age group stats is to evaluate for an "Abteilung" how many many members of a given age group it has. For this the statistics of the PBS-wagon can be extended. When a new data set is being calculated the age group statistics should be counted as well and then stored to the database.

**Basic Idea of Implementation**

- Age groups are being calculated and stored as relational data when a new census is being created
- Switching to the new age group stats is done via an additional url-paramenter
- The census is then being evaluated and displayed accordingly to the mode

**Changes**

- `AgeGroupCount` model saves the count of female and male members of an "Abteilung" and an age group
- module `Patria::MemberCounter` to extend the method `count` of `MemberCounter` to calculate the members of an age group
- module `Patria::MemberCount` to extend `MemberCount` model with `has_many AgeGroups` relations
- Separate view hierarchy (at ../views/census_evalutation/base and ../views/census_evalutation/abteilung)
- module `Patria::CensusEvaluation::BaseController` extending `index` with switch over new url-parameters
- module `FilterNavigation` for the drop-down menu
- modules `Patria::Group::Abteilung`, `Patria::Group::Kantonalverband` and `Patria::Group::Bund` to support the evalutation of the age group counts on different levels (and some other helpers and modules, i.e. `Patria::CensusEvaluation`, `Patria::CensusEvaluationHelper`, `TotalFromAgeGroups`, `AgeGroupSum`)

**Interesting Links Gathered on the Way**

- [Explanation of extending methods of other classes](https://www.ruby-forum.com/topic/128131)

###Login via LDAP
The LDAP Feature integrates the possibility to use a external LDAP server to manage users. When a user logs in for the very first time with an active LDAP Account, a new user in hitobito will be created and username, name, prename and password will be filled in from the LDAP server. The rest of the data will then be stored only local and not on the LDAP server. To change passwords, the LDAP admin has to be contacted. 

###New Corps-Layer

###Address Autocomplete via Service 
