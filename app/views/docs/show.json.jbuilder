json.fileId @doc.id.to_s

json.fileType "document"

json.versionId "1"

if @doc.folder
	json.parent do
		json.extract! @doc.folder, :title, :rank 
		json._id @doc.folder.to_param
	end
else
	json.parent nil
end

json.meta do
    json.attribution @doc.attribution
    json.keywords @doc.keywords
    json.modified 1376412865000
    json.textDirection "ltr"
    json.textLanguage "en"
    json.title @doc.title
end


markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, {})


json.data do
    json.sections @doc.sections.sort_by{|e| e.rank || 1e6} do |section|
        json.title section.title || ""
        json.content (markdown.render( section.content  || ""))
    end
end

json.rel do
    json.affiliated []
    json.embedded []
end

json.url url_for(@doc)