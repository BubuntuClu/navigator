class Building < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address_changed? }

  def full_address
    ['Москва', address].compact.join(', ')
  end
end
