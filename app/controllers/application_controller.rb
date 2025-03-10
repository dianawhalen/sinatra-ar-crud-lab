require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  # index
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # new
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  # create
  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  # show
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # edit
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # update
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect to "/articles/#{ @article.id }"
  end

  # delete
  delete '/articles/:id/delete' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect to '/articles'
  end
end
