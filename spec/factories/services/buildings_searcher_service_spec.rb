require 'rails_helper'

RSpec.describe BuildingsSearcherService do
  before do
    ["ул. Каретный ряд, д. 3", "Ленинский пр., д. 32А, стр. 1", "Просп. Мира, д. 119","ул. Кузнецкий мост, д. 6/3"].each do |address|
      create(:building, address: address)
    end
  end

  subject { BuildingsSearcherService }

  it 'finds only 2 address near point' do
    buildings = subject.new({ latitude: 55.7531, longitude: 37.6213 }).call

    expect(buildings.size).to eq(2)
    expect(buildings.first[:distance]).to be < buildings.second[:distance]
  end

  it 'finds nothing' do
    expect(subject.new({ latitude: 55.6597, longitude: 37.5691 }).call.size).to eq(0)
  end
end

