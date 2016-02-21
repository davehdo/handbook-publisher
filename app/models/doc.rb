class Doc
  include Mongoid::Document
  belongs_to :folder
  embeds_many :sections

  field :fileType, type: String
  field :versionId, type: String
  field :attribution # i.e. author
  field :keywords
  field :title
  field :rank, type: Integer
  
  validates_presence_of :title
  
  accepts_nested_attributes_for :sections, reject_if: proc {|e| e["title"].blank? and e["content"].blank? and e["id"].blank?}, allow_destroy: true

  # this is required so client app knows how to interpret
  def itemType
    "document"
  end
  
  def ancestors
    [folder] + folder.ancestors
  end
end
