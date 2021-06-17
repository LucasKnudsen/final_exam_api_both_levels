class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, each_serializer: ArticleIndexSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: { article: article }
  end
end