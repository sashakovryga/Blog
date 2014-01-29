json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :name, :chaper_id
  json.url gallery_url(gallery, format: :json)
end
