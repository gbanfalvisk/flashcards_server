class CardSerializer < ActiveModel::Serializer
  attributes :id, :title_front, :descr_front, :title_back, :descr_back, :deck_count
end
