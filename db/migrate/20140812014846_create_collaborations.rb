class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :project, index: true
      t.belongs_to :collaborator, index: true

      t.timestamps
    end
  end
end
