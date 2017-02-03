class CardSerializer < ActiveModel::Serializer
    attributes :id, :user, :title_front, :descr_front, :title_back, :descr_back, :deck_count
  
    def user
        object.user.id
    end
end
