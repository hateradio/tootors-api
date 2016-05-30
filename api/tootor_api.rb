require 'json'

#ignore
MyApp.add_route('DELETE', '/api/tootor/{id}', {
  "resourcePath" => "/Tootor",
  "summary" => "Delete Tootor",
  "nickname" => "delete_tootor_by_id",
  "responseClass" => "Tootor",
  "endpoint" => "/tootor/{id}",
  "notes" => "Delete Tootor by an ID",
  "parameters" => [


    {
      "name" => "id",
      "description" => "ID of Tootor to fetch",
      "dataType" => "int",
      "paramType" => "path",
    },



    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('GET', '/api/tootor/{id}', {
  "resourcePath" => "/Tootor",
  "summary" => "Read Tootor",
  "nickname" => "find_tootor_by_id",
  "responseClass" => "Tootor",
  "endpoint" => "/tootor/{id}",
  "notes" => "Find tootor by an ID",
  "parameters" => [


    {
      "name" => "id",
      "description" => "ID of Tootor to fetch",
      "dataType" => "int",
      "paramType" => "path",
    },



    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  tootor = TootorsDb.find(params['id'])

  if (tootor)
    tootor.to_json
  else
    404
  end
end


MyApp.add_route('POST', '/api/login', {
  "resourcePath" => "/Tootor",
  "summary" => "Account access",
  "nickname" => "login_post",
  "responseClass" => "Tootor",
  "endpoint" => "/login",
  "notes" => "Log in and out of Tootors app\n",
  "parameters" => [

    {
      "name" => "username",
      "description" => "",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },

    {
      "name" => "password",
      "description" => "",
      "dataType" => "string",
      "paramType" => "query",

      "allowableValues" => "",

    },




    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  tootor = TootorsDb.find_with_password(params['id'], params['password'])

  if (tootor)
    tootor.to_json
  else
    status 404
    body({code: 404, message: 'Invalid username or password!'}.to_json)
  end

end

#ignored
MyApp.add_route('POST', '/api/logout', {
  "resourcePath" => "/Tootor",
  "summary" => "Account access",
  "nickname" => "logout_post",
  "responseClass" => "Tootor",
  "endpoint" => "/logout",
  "notes" => "Log in and out of Tootors app\n",
  "parameters" => [




    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  status 200
  body({code: 200, message: 'Logged out!'}.to_json)

end

#todo
MyApp.add_route('PUT', '/api/tootor/{id}', {
  "resourcePath" => "/Tootor",
  "summary" => "Update Tootor",
  "nickname" => "update_tootor_by_id",
  "responseClass" => "Tootor",
  "endpoint" => "/tootor/{id}",
  "notes" => "Update tootor by an ID",
  "parameters" => [


    {
      "name" => "id",
      "description" => "ID of Tootor to fetch",
      "dataType" => "int",
      "paramType" => "path",
    },



    ]}) do
  cross_origin
  # the guts live here
  content_type :json

  tootor = TootorsDb.find(params[:id])

  if (tootor.errors.length > 0)
    tootor.to_json_with_errors
    code 404
    body({code: 404, message: 'Could not save user'}.to_json)
  else

  end
end
