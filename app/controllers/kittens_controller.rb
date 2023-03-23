class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = "Congrats! Your kitten has been added!"
      redirect_to @kitten
    else
      flash.now[:error] = "Oh no! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = "Congrats! Your kitten has been updated!"
      redirect_to @kitten
    else
      flash.now[:error] = "Oh no! Fix your mistakes, please."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = "Kitten has been deleted!"
    redirect_to root_path, status: :see_other
  end

  private
    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end

end
