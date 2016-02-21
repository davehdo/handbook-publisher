class Section
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :rank, type: Integer # stores the rank order
    
  embedded_in :doc
end
