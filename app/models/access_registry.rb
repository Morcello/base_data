class AccessRegistry < ApplicationRecord
  belongs_to :register_of_owner, optional: true
end
