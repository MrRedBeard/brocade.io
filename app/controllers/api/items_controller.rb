class Api::ItemsController < ApplicationController
  include Rails::Pagination

  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = if params[:query]
      Product.full_text_search(params[:query].split)
    else
      paginate(Product.all)
    end
  end

  def show
  end

  # TODO Add
  # def create
  #   @item = Product.new(item_params)

  #   respond_to do |format|
  #     if @item.save
  #       format.json { render :show, status: :created, location: @item }
  #     else
  #       format.json { render json: @item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @item.update(item_params)
  #       format.json { render :show, status: :ok, location: @item }
  #     else
  #       format.json { render json: @item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def set_item
    @item = if params[:id] == '00000000000000'
      test_item
    else
      Product.find_by(gtin: params[:id])
    end
  end

  def item_params
    params.fetch(:item, {})
  end

  # TODO the Datakick test item also has images attached.
  #
  def test_item
    Product.new(
      gtin: '00000000000000',
      properties: {
         brand_name: "ayam",
         name: "testname",
         size: "081216382297",
         ingredients: "Chocolate",
         serving_size: "34g",
         servings_per_container: "10",
         calories: 5,
         fat_calories: 5,
         fat: 0.5,
         saturated_fat: 0.5,
         trans_fat: 0.5,
         polyunsaturated_fat: 0.5,
         monounsaturated_fat: 0.5,
         cholesterol: 0,
         sodium: 0,
         potassium: 0,
         carbohydrate: 0,
         fiber: 0,
         sugars: 0,
         protein: 0,
         author: "MyAuthor",
         publisher: "MyPublisher",
         pages: 0,
         alcohol_by_volume: 40.0,
      }
    )
  end
end
