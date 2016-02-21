json.fileId doc.id.to_s

json.fileType "document"

json.versionId "1"

json.meta do
    json.title doc.title || ""
    json.modified 1426293146000
end

json.rel do
    json.affiliated []
    json.embedded []
end

json.url url_for(doc)