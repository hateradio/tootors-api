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
    p tootor.to_json_with_errors
  else
	   {"message" => "yes, it worked"}.to_json
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

  if (params['name'])
    tootors = TootorsDb.search('name', params['name'])
  elsif (params['location'])
    tootors = TootorsDb.search('zip', params['location'])
  elsif (params['focus'])
    tootors = TootorsDb.search('focus', params['focus'])
  elsif (params['is_tootor'])
    bool = params['is_tootor'] == "true"
    tootors = TootorsDb.search('is_tootor', bool)
  else
    tootors = TootorsDb.all
  end

  {status: 200, num_tuples: tootors.length, items: tootors}.to_json
end
