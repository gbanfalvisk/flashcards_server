class DeckSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :descr, :color, :card_count

  def user_id
    object.user.id
  end
end
