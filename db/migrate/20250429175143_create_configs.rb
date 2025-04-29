class CreateConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :configs, id: :uuid do |t|
      t.string :token, null: false
      t.string :domain, null: false

      t.timestamps
    end
  end
end
