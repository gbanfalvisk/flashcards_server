module Api::V1
  class DecksController < AuthedController
    before_action :attempt_set_deck, only: [:show, :update, :destroy]

  # GET /decks
  def index
    @decks = Deck.where(user:@current_user)
    render json: @decks
  end

  # GET /decks/1
  def show
    render json: @deck
  end

  # POST /deck
  def create
    params = deck_params
    params[:user] = @current_user
    @deck = Deck.new(params)

    if @deck.save
      render json: @deck, status: :created
    else
      render json: @deck.errors, status: :unprocessable_entity
    end
  end

  # DELETE /decks/1
  def destroy
    @deck.destroy
  end

  # PATCH/PUT /decks/1
  def update
    if @deck.update(deck_params)
      render json: @deck
    else
      render json: @deck.errors, status: :unprocessable_entity
    end
  end

  private

    def attempt_set_deck
      set_deck || render_deck_missing
    end

    def render_deck_missing
      render json: {'deck' => ["deck-not-found"]}, status: 404
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      return @deck = Deck.where(id:params[:id], user:@current_user).first
    end

    # Only allow a trusted parameter "white list" through.
    def deck_params
      params.require(:deck).permit(:title, :descr, :color)
    end

  end
end