require 'till'

describe Till do
  let(:latte) { double :item, name: 'latte', price: 475 }
  let(:americano) { double :item, name: 'amercano', price: 375 }
  let(:muffin) { double :item, name: 'muffin', price: 405 }

  it 'responds to the method order' do
    expect(subject).to respond_to :order
  end

  it 'can receive an order for a latte' do
    expect(subject.order(latte)).to eq [latte]
  end

  it 'responds to the method cash_out' do
    expect(subject).to respond_to :cash_out
  end

  it 'returns the total' do
    2.times { subject.order latte }
    expect(subject.cash_out).to eq 950
  end

  it 'returns the item total' do
    3.times { subject.order latte }
    expect(subject.item_total(latte)).to eq 1425
  end

  it 'calculates the tax due' do
    3.times { subject.order latte }
    subject.order americano
    2.times { subject.order muffin }
    expect(subject.tax).to eq 226
  end

  it 'receives payment' do
    expect(subject.payment(1000)).to eq 1000
  end

  it 'knows if there are muffins in the order' do
    2.times { subject.order muffin }
    expect(subject.muffins?).to eq true
  end

  it 'knows if there are no muffins in the order' do
    2.times { subject.order americano }
    expect(subject.muffins?).to eq false
  end

  xit 'applies a discount on the muffins in an order' do
    2.times { subject.order muffin }
    expect(subject.cash_out).to eq 729
  end
end
