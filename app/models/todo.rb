class Todo < ApplicationRecord
    has_many :todo_tags, dependent: :destroy
    has_many :tags, through: :todo_tags
  end