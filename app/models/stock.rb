class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :store
end
