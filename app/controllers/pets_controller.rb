class PetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      redirect_to @pet, notice: "Pet added successfully!"
    else
      render :new
    end
  end

  def index
    @query = params[:q] || {}
    @pets = Pet.all

    # Filter by location if a location is provided in the query
    if @query[:location].present?
      @pets = @pets.where(location: @query[:location])
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :location, :age, :pet_type, :breed)
  end
end
