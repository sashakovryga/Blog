json.array!(@chapers) do |chaper|
  json.extract! chaper, :id, :title, :description
  json.url chaper_url(chaper, format: :json)
end
