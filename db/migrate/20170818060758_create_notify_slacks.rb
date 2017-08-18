class CreateNotifySlacks < ActiveRecord::Migration[5.1]
  def change
    create_table :notify_slacks do |t|

      t.timestamps
    end
  end
end
