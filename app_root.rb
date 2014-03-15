# define the root directory of the main application
#ENV['APP_ROOT'] ||= File.expand_path(__FILE__).split("vendor#{File::SEPARATOR}wagons").first
ENV['APP_ROOT'] ||= File.expand_path('../../hitobito', __FILE__)
#ENV['APP_ROOT'] ||= File.expand_path(__FILE__).split("app_root.rb").first
