class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  layout "portfolio"
  
  def index
    @portfolio_items = Portfolio.all
  end
  
  def new
    @portfolio = Portfolio.new
    3.times { @portfolio.technologies.build  }
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
                                        technologies_attributes: [:name]
                                        )
   end
  
   def set_portfolio
      @portfolio = Portfolio.find(params[:id])
   end
end
