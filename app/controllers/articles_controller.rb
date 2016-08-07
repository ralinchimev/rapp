class ArticlesController < ApplicationController
  before_action :force_authentication, except: [:index, :show]
  before_action :article, only: [:show, :edit]

  def index
    force_authentication if params[:show]
    @articles = ArticlesService.articles params[:show]
  end

  def show
    force_authentication if article.status != 'published'
  end

  def new
    @article = Article.new
  end

  def create
    success, @article = ArticlesService.create_article article_params
    if success
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    if article.update_attributes article_params
      redirect_to article
    else
      render :edit
    end
  end

  def destroy
    article.destroy
    redirect_to articles_url
  end

  private

  def article_params
    params.require(:article).permit(:title, :slug, :status, :content)
  end

  def article
    @article ||= Article.find params[:id]
  end
end
