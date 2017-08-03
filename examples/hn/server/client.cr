require "http/server"

indexPath = "./dist/index.html"
cssPath = "./dist/css/build.9b60815d8f.css"
jsPath = "./dist/js/build.cf4b6320a1.js"
imgPath = "./dist/img/logo.png"

index = File.read(indexPath)
css = File.read(cssPath)
js = File.read(jsPath)
img = File.read(imgPath)

server = HTTP::Server.new(8080) do |context|
  response = context.response
  path = context.request.path

  if path.bytesize == 1
    response.content_type = "text/html"
    response.print index
  else
    case path[1..2]
    when "cs"
      response.content_type = "text/css"
      response.print css
    when "js"
      response.content_type = "text/javascript"
      response.print js
    when "im"
      response.content_type = "image/png"
      response.print img
    else
      response.content_type = "text/html"
      response.print index
    end
  end
end

server.listen
