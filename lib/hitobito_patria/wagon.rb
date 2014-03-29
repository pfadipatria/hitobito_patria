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
	  MemberCounter.send        :include, Patria::MemberCounter
    end 

  end
end
