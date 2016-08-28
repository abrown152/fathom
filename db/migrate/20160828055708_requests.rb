class Requests < ActiveRecord::Migration
  def change
    t.string :username
    t.string :location
    t.float :anger
    t.float :disgust
    t.float :fear
    t.float :joy
    t.float :sadness
    t.float :analytical
    t.float :confident
    t.float :tentative
    t.float :openness
    t.float :conscientiousness
    t.float :extraversion
    t.float :agreeableness
    t.float :emotional_range
  end
end
