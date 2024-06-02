class Client < ApplicationRecord
    has_many :sales, dependent: :destroy
end
