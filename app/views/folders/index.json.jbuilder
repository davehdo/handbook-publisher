json.modules ["module-1"].each do |title|
  json.module do
    json.set! "@", "26f09d1c"
    json.moduleId "55037ac5e07f2f486200029a"
    json.meta do
      json.isArtDefault false
      json.isPersonal false
      json.art do
        json.set! "128", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/1jz/3/e/55037ac5e07f2f486200029a/0c559b58-0dd3-41f4-b5ca-bc012247d531.128.png"
        json.set! "256", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/1jz/3/e/55037ac5e07f2f486200029a/0c559b58-0dd3-41f4-b5ca-bc012247d531.256.png"
        json.set! "512", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/1jz/3/e/55037ac5e07f2f486200029a/0c559b58-0dd3-41f4-b5ca-bc012247d531.512.png" 
      end
      
      json.artFeature do
        json.set! "320", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/_default/hvpwt0fk.320.png"
        json.set! "640", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/_default/hvpwt0fk.640.png"
        json.set! "960", "https://d2p53dh3qxfm0x.cloudfront.net/assets/art/_default/hvpwt0fk.960.png"
      end
      
      json.artFeatureFill "#ffffff"
      
      json.description ""
      json.title "Module"
      json.subtitle ""
    end
      
    json.data do
      # this must contain all the files that are referenced
      json.files Doc.all.each do |file| 
        json.partial! 'docs/doc', doc: file
      end
      
      # all the first and second level folders must be included
      json.folders do 
      
        # the first folder is the 'root' folder, which contains all the top level folders
        json.set! "root_folder_id" do
          json.title "root"
          json.items Folder.top_level do |folder|
            json.itemId folder.id.to_s
            json.itemType "folder"
          end
          json.fileCount 50
        end
        
        # now include all the folders (at every level)
        Folder.all.each do |folder|
          json.set! folder.id.to_s do
            json.title folder.title || ""
            json.items (folder.subfolders + folder.docs) do |item|
              json.itemId item.id.to_s
              json.itemType item.itemType
            end
            json.fileCount folder.descendant_docs.size
          end
        end
        
      end
      
      # this must be a valid folder_id for folder that is included above
      json.rootFolderId "root_folder_id"
      
    end
    
    json.urlBundle "_"
  end
  
  json._responseVersion "0.0.1"
  json._responseType "module"

end

json._responseVersion "0.0.1"
json._responseType "modules"