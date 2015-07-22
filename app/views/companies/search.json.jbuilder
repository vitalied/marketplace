json.total_count @companies_count

json.items @companies do |company|
  json.id company.id
  json.text company.name
end
