class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :token, limit: 255
			t.integer :need_ks1, limit: 1, default: 0
			t.integer :need_ks2, limit: 1, default: 0
			t.integer :need_ks3, limit: 1, default: 0
			t.integer :need_ks4, limit: 1, default: 0
			t.integer :need_ks5a, limit: 1, default: 0
			t.integer :need_ks5b, limit: 1, default: 0
			t.integer :need_ks6, limit: 1, default: 0
			t.timestamps
		end
	end
end