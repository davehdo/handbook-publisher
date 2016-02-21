class Folder
  include Mongoid::Document
  has_many :docs
  has_many :subfolders, class_name: "Folder", inverse_of: :parent
  belongs_to :parent, class_name: "Folder", inverse_of: :subfolders
  
  field :title, type: String
  field :attribution
  field :keywords
  field :rank, type: Integer
  
  # used when saving ranks
  accepts_nested_attributes_for :subfolders
  accepts_nested_attributes_for :docs
  # validates_presence_of :title

  scope :top_level, -> { where(:parent_id.in => [nil, ""])}
  
  # this is required so client app knows how to interpret
  def itemType
    "folder"
  end

  # returns "folder/subfolder/subsubfolder"
  def full_path
    (ancestors.reverse + [self]).collect {|e| e.title}.join("/")
  end
  
  def ancestors
    if parent
      [parent] + parent.ancestors
    else
      []
    end
  end
  
  
  # returns descendant folders, not documents
  def descendants
    self.subfolders.collect do |s|
      [s] + s.descendants
    end.flatten
  end
  
  # returns descendant documents
  def descendant_docs
    ([self] + descendants).collect {|e| e.docs }.flatten.uniq
  end
  
  def items
    (self.docs + self.subfolders).sort_by {|e| e.rank || 99}
  end
  
  def items_attributes=(attrib)
    self.subfolders_attributes= attrib.select {|k,v| Folder.where(id: v["id"] ).any?}
    self.docs_attributes= attrib.select {|k,v| Doc.where(id: v["id"] ).any? }
  end
end
