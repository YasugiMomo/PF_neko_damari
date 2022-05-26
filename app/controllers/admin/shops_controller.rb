class Admin::ShopsController < ApplicationController

  def index
    # 絞り込み機能
    if params[:star_count_desc]
      @shops = Shop.all.each do |shop|
        shop.average = shop.avg_rate
      end
      @shops = @shops.sort_by{ |shop| shop.avg_rate }.reverse
      @shops = Kaminari.paginate_array(@shops).page(params[:page]).per(5)
    elsif params[:star_count_asc]
      @shops = Shop.all.each do |shop|
        shop.average = shop.avg_rate
      end
      @shops = @shops.sort_by{ |shop| shop.avg_rate }
      @shops = Kaminari.paginate_array(@shops).page(params[:page]).per(5)
    else
      @shops = Shop.page(params[:page]).per(5)
    end
  end


  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews
    @review = Review.new
    @tag_list = Tag.all
  end

  def search
    @shops = Shop.looks(params[:word])
  end
end
