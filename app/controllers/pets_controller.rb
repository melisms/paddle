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
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :location, :pet_type, :breed)
  end
end
