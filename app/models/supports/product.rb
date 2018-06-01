class Supports::Product
  attr_reader :all_categories, :all_providers

  def initialize
    @all_categories = Category.get_list_name
    @all_providers = Provider.get_list_name
  end
end
