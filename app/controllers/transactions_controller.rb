class TransactionsController < ApplicationController
  before_action :set_category

  def index
    @transactions = @category.entities.includes(:group)
  end

  def new
    @transaction = Entity.new
  end

  def create
    @transaction = @category.entities.new(transaction_params)
    @transaction.author_id = current_user.id

    if @transaction.save
      redirect_to home_show_path
    else
      flash[:error] = @transaction.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Group.find(params[:category_id])
  end

  def transaction_params
    params.require(:entity).permit(:name, :amount)
  end
end
