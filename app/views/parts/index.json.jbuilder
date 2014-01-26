json.array!(@parts) do |part|
  json.extract! part, :id, :name, :body
  json.url part_url(chaper_parts_path, format: :json)
end
