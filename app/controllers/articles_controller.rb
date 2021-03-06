class ArticlesController < ApplicationController
  
  
  before_action :find_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except:[:show,:index]
  before_action :require_same_user, only:[:edit,:destroy,:update]
  def new
    @article=Article.new 
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success]="Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def index
    @articles = Article.paginate(page: params[:page],per_page: 5)
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success]="Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
end
  
  def destroy
     @article.destroy
    flash[:destroy] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def find_article
     @article = Article.find(params[:id])
  end
end
