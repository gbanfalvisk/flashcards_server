module Api::V1::Me
  class DeckcardsController < Api::V1::AuthedController
    before_action :attempt_set_deckcard, only: [:show, :destroy]

  # GET /deckcards
  def index
    @deckcards = DeckCard.where(user:@current_user)
    render json: @deckcards
  end

  # GET /deckcards/1
  def show
    render json: @deckcards
  end

  # POST /deckcard
  def create
    params = deckcard_params
    params[:user] = @current_user
    
    deckExistsAndIsUsers = false
    cardExistsAndIsUsers = false
    
    if (deck = Deck.where(id:params[:deck], user:@current_user).first)
        deckExistsAndIsUsers = true
        params[:deck] = deck
    end

    if (card = Card.where(id:params[:card], user:@current_user).first)
        cardExistsAndIsUsers = true
        params[:card] = card
    end



    if (!deckExistsAndIsUsers || !cardExistsAndIsUsers)
        render json: {'deckcard' => ["card-deck-not-found"]}, status: 404
    else 
        @deckcard = DeckCard.new(params)

        if @deckcard.save
        render json: @deckcard, status: :created
        else
        render json: @deckcard.errors, status: :unprocessable_entity
        end
    end
  end

  # DELETE /deckcards/1
  def destroy
    @deckcard.destroy
  end


  private

    def attempt_set_deckcard
      set_deckcard || render_deckcard_not-found
    end

    def render_deckcard_missing
      render json: {'deckcard' => ["card-deck-missing"]}, status: 404
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_deckcard
      return @deckcard = DeckCard.where(id:params[:id], user:@current_user).first
    end

    # Only allow a trusted parameter "white list" through.
    def deckcard_params
      params.require(:deckcard).permit(:deck, :card)
    end

  end
end