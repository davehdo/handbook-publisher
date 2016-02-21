json.array!(@docs) do |doc|
  json.extract! doc, :id, :fileType, :meta
  json.url doc_url(doc, format: :json)
end
