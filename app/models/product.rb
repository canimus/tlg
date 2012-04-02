class Product < ActiveRecord::Base
  serialize :tags, Array
  serialize :properties, Hash
  
  scope :by_name, lambda { |*filter|
    filter = filter.first if filter.first.is_a? Array
    filter.collect! { |s| "%#{s}%" }
    clauses = filter.map { |l| 
      "name like ?" 
    }
    clauses = clauses.join(" or ") if clauses.length > 0
    where filter.prepend clauses
  }
  
  def self.method_missing method_id, *args
    if match = method_id.to_s.match(/^([a-zA-Z]\w*)_like\?$/)
      self.where("#{match.captures.first} like ?", "%#{args[0]}%")
    end
  end
    
end
