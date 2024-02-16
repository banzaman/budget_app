class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Group.includes(:entities).all
  end

  def show
    @category = Group.includes(:entities).find(params[:category_id])
    @transactions = @category.entities.order('created_at DESC')
  end

  def new
    @category = Group.new
  end

  def create
    @category = Group.new(category_params)
    @category.author_id = current_user.id
    if @category.save
      redirect_to home_index_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:group).permit(:name, :icon)
  end
end
