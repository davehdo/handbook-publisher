json.fileId @doc.id.to_s

json.fileType "document"

json.versionId "1"

json._id @doc.to_param

if @doc.folder
	json.parent do
		json.extract! @doc.folder, :title, :rank 
		json._id @doc.folder.to_param
	end
else
	json.parent nil
end

json.extract! @doc, :attribution, :keywords, :title

json.meta do
    json.modified 1376412865000
    json.textDirection "ltr"
    json.textLanguage "en"
end


markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, {})

json.sections @doc.sections.sort_by{|e| e.rank || 1e6} do |section|
    json.extract! section, :title, :content, :rank
 	json.id section.to_param
    json.content_html (markdown.render( section.content  || ""))
end

json.rel do
    json.affiliated []
    json.embedded []
end

json.url url_for(@doc)