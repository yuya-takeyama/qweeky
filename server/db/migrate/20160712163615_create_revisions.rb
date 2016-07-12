class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.references :page
      t.references :user
      t.text :content

      t.timestamps
    end
  end
end
