json.array!(@inspection_templates) do |inspection_template|
  json.extract! inspection_template, :id
  json.url inspection_template_url(inspection_template, format: :json)
end
