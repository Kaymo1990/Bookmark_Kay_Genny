
require 'sinatra/base'
require './lib/bookmark'
require './lib/database_connection_setup'
require './lib/database_connection'

class BookmarkManager < Sinatra::Base
  get '/' do
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end


  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

    enable :sessions, :method_override

  delete '/bookmarks/:id' do
  Bookmark.delete(id: params[:id])
  redirect '/bookmarks'
end

# get '/bookmarks/:id/edit' do
#   @bookmark_id = params[:id]
#   erb :'bookmarks/edit'
# end

patch '/bookmarks/:id' do
  Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
  redirect '/bookmarks'
end

get '/bookmarks/:id/edit' do
  @bookmark = Bookmark.find(id: params[:id])
  erb :"bookmarks/edit"
end



  run! if app_file == $0
end
