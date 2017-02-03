class DeckSerializer < ActiveModel::Serializer
  attributes :id, :user, :title, :descr, :color, :card_count

  def user
    object.user.id
  end
end
