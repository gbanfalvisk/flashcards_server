module Api::V1
  class CardsController < AuthedController
    before_action :attempt_set_card, only: [:show, :update, :destroy]

  # GET /cards
  def index
    @cards = Card.where(user:@current_user)
    render json: @cards
  end

  # GET /cards/1
  def show
    render json: @card
  end

  # POST /card
  def create
    params = card_params
    params[:user] = @current_user
    @card = Card.new(params)

    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
  end

  # PUT /cards/1
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  private

    def attempt_set_card
      set_card || render_card_missing
    end

    def render_card_missing
      render json: {'card' => ["card-not-found"]}, status: 404
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_card
      return @card = Card.where(id:params[:id], user:@current_user).first
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:title_front, :descr_front, :title_back, :descr_back)
    end

  end
end