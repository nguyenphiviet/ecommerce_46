class Provider < ApplicationRecord
  has_many :products

  def self.get_list_name
    select :id, :name
  end
end
