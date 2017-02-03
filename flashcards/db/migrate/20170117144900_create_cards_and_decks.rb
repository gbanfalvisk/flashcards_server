class CreateCardsAndDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      #rels
      t.belongs_to :user, index: true

      #attribs
      t.string :title
      t.string :descr
      t.string :color
      t.timestamps
    end

    create_table :cards do |t|
      #rels
      t.belongs_to :user, index: true

      # attribs
      t.string :title_front
      t.string :descr_front
      t.string :title_back
      t.string :descr_back
      t.timestamps
    end

    create_table :deck_cards do |t|
      #rels
      t.belongs_to :deck, index: true
      t.belongs_to :card, index: true
      t.belongs_to :user, index: true

      #attribs
      t.timestamps
    end
  end
end
