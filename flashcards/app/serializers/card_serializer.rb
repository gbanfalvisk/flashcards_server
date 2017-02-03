class CardSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :title_front, :descr_front, :title_back, :descr_back, :deck_count
  
    def user_id
        object.user.id
    end
end
