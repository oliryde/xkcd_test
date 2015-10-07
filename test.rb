require 'oga'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require "net/https"
require "uri"

def request_image(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

  case response
    when Net::HTTPSuccess
      return response
    when Net::HTTPRedirection
      return request_image(response['location'])
  end
end

def get_image
  response = request_image("https://c.xkcd.com/random/comic/")
  document = Oga.parse_html(response.body)
  img = document.at_css('#comic img')
  header = document.at_css('#ctitle')
  image = Hash.new
  image[:url] = img.attribute('src')
  image[:description] = img.attribute('title')
  image[:title] = header.text
  puts image
  return image
end

get '/' do
  image = get_image
  @url = image[:url]
  @title = image[:title]
  @description = image[:description]
  erb :index
end

get '/json' do
  erb :json
end

get '/image.json' do
  content_type :json
  get_image.to_json
end
