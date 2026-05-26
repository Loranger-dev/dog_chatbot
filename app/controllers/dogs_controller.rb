class DogsController < ApplicationController
  def new
    @dog = Dogs.new
  end

  def create
    @dog = Dog.new(dog_params)

    if @dog.save
      redirect_to dog_path(@dog), notice: "Profil du chien créé avec succés."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])

    if @dog.update(dog_params)
      redirect_to dog_path(@dog), notice: "Profil du chien mis à jour."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
    redirect_to dogs_path, notice: "Profil du chien supprimé."
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :description, :user_id)
  end

end
