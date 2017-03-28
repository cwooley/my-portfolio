class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  layout "portfolio"
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  
  def index
    @portfolio_items = Portfolio.by_position
  end
  
  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end
    
    render nothing: true
  end
  
  
  def new
    @portfolio = Portfolio.new

  end
  
  def create
     @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit

  end

  def update
    
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
      else
          format.html { render :edit }
      end
    end
  end
  
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html {redirect_to portfolios_url, notice: 'portfolio has been deleted.' }
    end
  end
  
  def show
  
  end
  
  
  private
  
   def portfolio_params
      params.require(:portfolio).permit(:title,
                                        :subtitle,
                                        :body,
                                        :thumb_image,
                                        :main_image,
                                        technologies_attributes: [:id, :name, :_destroy]
                                        )
   end
  
   def set_portfolio
      @portfolio = Portfolio.find(params[:id])
   end
   

end
