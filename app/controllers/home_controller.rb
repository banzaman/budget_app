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

  def new2
    @category = Group.new
  end

  def create
    @category = Group.new(category_params)
    @category.author_id = current_user.id
    puts @category.inspect
    puts @category.author_id
    if @category.save
      puts 'Entered the redirection option.'
      redirect_to home_index_path
    else
      puts 'We have an error while creating the Category.'
      flash[:error] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:group).permit(:name, :icon)
  end
end
