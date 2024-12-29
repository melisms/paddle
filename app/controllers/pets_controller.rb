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
    if params[:location].present?
      @pets = Pet.where(location: params[:location])
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @owner = @pet.user
  end

  private

def pet_params
  params.require(:pet).permit(:name, :location, :age, :pet_type, :breed, :description, :image)
end
end
