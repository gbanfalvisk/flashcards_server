class DeckSerializer < ActiveModel::Serializer
  attributes :id, :title, :descr, :color, :card_count
end
