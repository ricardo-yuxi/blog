class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  before_action :authenticate_user!, only: [:new, :edit, :destroy]


  def index
    @articles = Article.all.order(created_at: :desc).limit(10)
    @art_top_five = Article.comment_num
  end

  def new
    @article = Article.new
  end

  def show 
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      render 'create'
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end    
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

end
