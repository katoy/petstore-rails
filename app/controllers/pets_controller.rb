# frozen_string_literal: true

# ペット
class PetsController < ApplicationController
  def index
    pets = Pet.all.order(id: :ASC)
    render json: { pets: }
  end

  def show
    id = params[:id]
    pet = Pet.where(id:)[0]
    render json: { pet: }
  end

  def create
    pet = Pet.new(pet_params)
    if pet.save
      render json: PetSerializer.new(pet), status: :created
    else
      render json: ErrorSerializer.new(pet), status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.permit(:name, :tag)
  end
end
