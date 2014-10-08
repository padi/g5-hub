class Vendor < ActiveRecord::Base
  validates :name, uniqueness: true, allow_ni: false
end