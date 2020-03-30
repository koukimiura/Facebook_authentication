class ArticlesController < ApplicationController
    before_action :check, only: [:edit, :update, :destroy]
    before_action :authnecate_user!, except: [:index]
    
    
    def index
        @articles = Article.all.order(created_at: :desc)
    end
    
    def new
        @article = Article.new
    end
    
    def create
        @article = Articel.new(article_params)
        
        if @article.save?
            flash[:notice] = "記事を作成しました。"
            redirect_to root_path
        else
            
            render :new
            
        end
        
    end
    
    def edit 
        
    end
    
    def update
        
    end
    
    
    def destroy
        
        @article.destroy
        redirect_to root_path
    end
    
    
    private
    
    
    def check
        
        @article = Article.find_by(id: params[:id])
        
    end
    
    def article_params
        
        params.require(:article).permit(:title, :content)
        
    end
    
end
