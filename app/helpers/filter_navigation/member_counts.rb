module FilterNavigation
  class MemberCounts < Base

    attr_reader :name, :year
    
    delegate :can?, to: :template

    def initialize(template, name, year)
      super(template)
      @name = name
      @year = year
      
      init_filter_names
      init_labels
      init_dropdown_links
    end

    private
    
    def init_filter_names
      @filter_names = ["Nach Typ", "Nach Jahrgang"]
    end

    def init_labels
      dropdown.active = true
      if name.present?
        dropdown.label = name
      else
        dropdown.label = main_filter_name
      end
    end

    def main_filter_name
      @filter_names.first
    end

    def init_dropdown_links
      dropdown.item(@filter_names.first, template.url_for(:year => year))
      dropdown.item(@filter_names.second, template.url_for(:year => year, :name => @filter_names.second))
    end

  end
end
