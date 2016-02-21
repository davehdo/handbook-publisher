json.extract! folder, :title, :attribution, :keywords, :rank
json.parent_id (folder.parent ? folder.parent.to_param : nil)
json._id folder.to_param

if folder.parent
	json.parent do
		json.extract! folder.parent, :title, :rank 
		json._id folder.parent.to_param
	end
else
	json.parent nil
end

json.subfolders folder.subfolders.sort_by {|e| e.rank || 1e6} do |subfolder|
	json.extract! subfolder, :title, :rank
	json._id subfolder.to_param
end

json.docs folder.docs.sort_by {|e| e.rank || 1e6} do |doc|
	json.extract! doc, :title, :rank
	json._id doc.to_param
end