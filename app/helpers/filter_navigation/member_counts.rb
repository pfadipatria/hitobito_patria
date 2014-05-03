module FilterNavigation
  class MemberCounts < Base
    
    attr_reader :name, :year
    
    delegate :can?, to: :template

    FILTER_NAMES = ["Nach Typ", "Nach Jahrgang"]
    
    def initialize(template, name, year)
      super(template)
      @name = name
      @year = year
      
      init_labels
      init_dropdown_links
    end
    
    private
    
    def init_labels
      dropdown.active = true
      if name.present?
        dropdown.label = name
      else
        dropdown.label = main_filter_name
      end
    end

    def main_filter_name
      FILTER_NAMES.first
    end

    def init_dropdown_links
      dropdown.item(FILTER_NAMES.first, template.url_for(:year => year))
      dropdown.item(FILTER_NAMES.second, template.url_for(:year => year, :name => FILTER_NAMES.second))
    end


    class << self
      
      def shows_agegroups?(name)
        name == FILTER_NAMES.second
      end
    end
    
  end
end
