class CreateSiteContents < ActiveRecord::Migration[5.2]
  def change
    create_table :site_contents do |t|
      t.string :type
      t.text :context

      t.timestamps
    end
  end
end
