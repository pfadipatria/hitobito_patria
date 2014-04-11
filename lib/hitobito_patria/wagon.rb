module HitobitoPatria
  class Wagon < Rails::Engine
    include Wagons::Wagon
    
    # Set the required application version.
    app_requirement '>= 0'

    # Add a load path for this specific wagon
    # config.autoload_paths += %W( #{config.root}/lib )

    config.autoload_paths += %W( #{config.root}/app/domain

                           )

    config.to_prepare do
      # extend application classes here
      MemberCount.send           :include, Patria::MemberCount
      MemberCounter.send         :include, Patria::MemberCounter
      CensusEvaluation.send      :include, Patria::CensusEvaluation
      CensusEvaluation::BaseController.send  :include, Patria::CensusEvaluation::BaseController
      CensusEvaluationHelper.send :include, Patria::CensusEvaluationHelper
      Group.send                 :include, Patria::Group
      Group::Abteilung.send      :include, Patria::Group::Abteilung
      Group::Kantonalverband.send :include, Patria::Group::Kantonalverband
      Group::Bund.send           :include, Patria::Group::Bund

      Person.send                 :include, Patria::Person
      ApplicationController.send  :include, Patria::ApplicationController
      Devise::RegistrationsController.send :include, Patria::Devise::RegistrationsController
    end 

  end
end
