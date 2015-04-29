feature 'As a customer I want to be able to order items from a coffee shop' do
  let(:till) { Till.new }
  let(:latte) { double :item, name: 'latte', price: 475 }
  let(:americano) { double :item, name: 'amercano', price: 375 }
  let(:muffin) { double :item, name: 'muffin', price: 405 }
  let(:flat_white) { double :item, name: 'Flat White', price: 475 }
  let(:cappuccino) { double :item, name: 'cappucino', price: 385 }
  let(:mudcake) { double :item, name: 'mudcake', price: 640 }
  let(:mousse) { double :item, name: 'mousse', price: 820 }
  let(:affogato) { double :item, name: 'affogato', price: 1480 }
  let(:tiramisu) { double :item, name: 'tiramisu', price: 1140 }

  scenario 'Jane orders 2 cafe lattes' do
    till.order latte
    till.order latte
    expect(till.cash_out).to eq 950
  end

  scenario 'John orders 4 Americanos' do
    4.times { till.order americano }
    expect(till.cash_out).to eq 1500
  end

  scenario 'Jane orders 2 cafe lattes and a blueberry muffin' do
    2.times { till.order latte }
    till.order muffin
    expect(till.cash_out).to eq 1355
  end

  scenario 'John orders 4 Americanos and a muffin' do
    4.times { till.order americano }
    till.order muffin
    expect(till.item_total(americano)).to eq 1500
  end

  scenario 'Chris orders 3 cafe lattes an Americano and 2 blueberry muffins' do
    3.times { till.order latte }
    till.order americano
    2.times { till.order muffin }
    expect(till.tax).to eq 226
  end

  scenario 'jane orders 1 cafe latte and pays with $10 and receives 5.25 change' do
    till.order latte
    till.payment 1000
    expect(till.change).to eq 525
  end

  scenario "John orders more then $50 worth of products and receieves a 5% discount" do
    till.order latte
    2.times { till.order flat_white }
    till.order cappuccino
    2.times { till.order mudcake }
    till.order mousse
    till.order affogato
    till.order tiramisu
    expect(till.discount?).to eq true
    expect(till.cash_out).to eq 6204
  end

  scenario "jane orders 1 cafe latte and receives no discount" do
    till.order latte
    expect(till.discount?).to eq false
  end

  xscenario 'John orders 2 muffins' do
    2.times { till.order muffin }
    expect(till.cash_out).to eq 729
  end

end
