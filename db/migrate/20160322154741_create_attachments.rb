class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :image
      t.integer :position
      t.belongs_to :post, index: true, foreign_key: true
      t.string :comment

      t.timestamps null: false
    end
  end
end
