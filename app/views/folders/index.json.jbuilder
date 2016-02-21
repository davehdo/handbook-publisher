# this should resemble show.json.jbuilder
json.array!(@folders) do |folder|
	json.partial! 'folders/folder', folder: folder
end
