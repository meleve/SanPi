class AddMontoimporteToCtaCte < ActiveRecord::Migration
  def change
    add_column :cta_ctes, :montoimporte, :integer
    add_index :cta_ctes, :montoimporte
  end
end
