# frozen_string_literal: true

# ペット
class PetsController < ApplicationController
  def index
    pets = Pet.all.order(id: :ASC)
    render json: PetSerializer.new(pets), status: :ok
  end

  def show
    id = params[:id]
    pet = Pet.where(id: id)[0]
    if pet
      render json: PetSerializer.new(pet), status: :ok
    else
      render json: {}, status: :not_found
    end
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
