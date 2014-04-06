module Patria::CensusEvaluation::BaseController
  extend ActiveSupport::Concern
  
  included do
    alias_method_chain :index, :filter
  end

  def index_with_filter
    if FilterNavigation::MemberCounts.shows_agegroups?(params[:name])
      @sub_groups = evaluation.sub_groups
      @group_counts = evaluation.age_counts_by_sub_group
      @min_birth_year = evaluation.min_birth_year
      @max_birth_year = evaluation.max_birth_year
      @total = evaluation.age_total
    else
      index_without_filter
    end

  end

end
