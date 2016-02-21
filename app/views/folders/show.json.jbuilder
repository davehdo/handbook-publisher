json.extract! @folder, :title, :attribution, :keywords, :rank
json.parent_id (@folder.parent ? @folder.parent.to_param : nil)
json._id @folder.to_param

json.subfolders @folder.subfolders do |subfolder|
	json.extract! subfolder, :title, :rank
	json._id subfolder.to_param
end

json.docs @folder.docs do |doc|
	json.extract! doc, :title, :rank
	json._id doc.to_param
end