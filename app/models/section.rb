class Section
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :z_index # stores the rank order
    
  embedded_in :doc
end
