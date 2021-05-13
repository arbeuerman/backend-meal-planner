class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.limit(params[:limit]).offset(params[:offset])

    render json: @recipes
  end

  def ingredients
    @recipe = Recipe.find(params[:recipe_id])
    # @recipe = Recipe.find(params[:recipe_id])
    # @recipe = Recipe.find_by(id: params[:recipe_id])
  #  byebug
    @ingredients = @recipe.ingredients
    render json: @ingredients
  end


  # GET /recipes/1
  def show
    render json: @recipe
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.recipe_ingredients.destroy_all
    @recipe.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :instructions, :image)
    end
end
