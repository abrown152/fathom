class Requests < ActiveRecord::Migration
  def change
    add_column :requests, :username, :string
    add_column :requests, :location, :string
    add_column :requests, :anger, :float
    add_column :requests, :disgust, :float
    add_column :requests, :fear, :float
    add_column :requests, :joy, :float
    add_column :requests, :sadness, :float
    add_column :requests, :analytical, :float
    add_column :requests, :confident, :float
    add_column :requests, :tentative, :float
    add_column :requests, :openness, :float
    add_column :requests, :conscientiousness, :float
    add_column :requests, :extraversion, :float
    add_column :requests, :agreeableness, :float
    add_column :requests, :emotional_range, :float
  end
end
