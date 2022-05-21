class Tagmap < ApplicationRecord
  belongs_to :review
  belongs_to :tag
end
