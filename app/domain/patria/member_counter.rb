module Patria::MemberCounter
  extend ActiveSupport::Concern
  def self.included(mod)
    mod.class_eval do
      alias_method_chain :count, :age_group
    end
  end

  def count_with_age_group
	Rails.logger.info "Calling extended count method using some sorcery"
	count_without_age_group
  end
end