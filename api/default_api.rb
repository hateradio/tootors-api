require 'json'


MyApp.add_route('POST', '/api/tootor', {
  "resourcePath" => "/Default",
  "summary" => "Create Tootor",
  "nickname" => "create_tootor_by_id",
  "responseClass" => "Tootor",
  "endpoint" => "/tootor",
  "notes" => "Update Tootor information",
  "parameters" => [

    {
      "name" => "api_key",
      "description" => "API Key",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },




    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  tootor = Tootor.new.fill(params)

  if (tootor.errors.length > 0)
    tootor.to_json_with_errors
  else
    saved = TootorsDb.insert(tootor)

    if (saved)
      tootor.to_json
    else
      status 400
      body({code: 400, message: 'Could not save user!'})
    end
  end

end


MyApp.add_route('GET', '/api/tootor', {
  "resourcePath" => "/Default",
  "summary" => "Gets all Tootors",
  "nickname" => "get_tootors",
  "responseClass" => "inline_response_200",
  "endpoint" => "/tootor",
  "notes" => "Search Tootors",
  "parameters" => [

    {
      "name" => "name",
      "description" => "Search Tootors by name",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },

    {
      "name" => "location",
      "description" => "Search Tootors by location",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },

    {
      "name" => "focus",
      "description" => "Search Tootors by focus",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },

    {
      "name" => "api_key",
      "description" => "Your API key",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },




    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  keys = ['is_tootor', 'name', 'location', 'focus']
  inter = keys & params.keys;

  hash = {}
  inter.each { |key| hash[key] = params[key] }

  find_tootors = hash['is_tootor'] == nil ? nil : hash['is_tootor'] == 'true'

  if (find_tootors && hash.length == 1)
    tootors = TootorsDb.search('is_tootor', find_tootors)
  elsif (hash['name'])
    tootors = TootorsDb.search('name', hash['name'], find_tootors)
  elsif (hash['location'])
    tootors = TootorsDb.search('zip', hash['location'], find_tootors)
  elsif (hash['focus'])
    tootors = TootorsDb.search('focus', hash['focus'], find_tootors)
  else
    tootors = TootorsDb.all
  end

  {status: 200, num_tuples: tootors.length, items: tootors}.to_json
end
