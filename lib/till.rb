class Till
  TAX_RATE = 0.0864
  DISCOUNT_VALUE = 5000
  DISCOUNT_RATE = 0.05

  def initialize
    @order_items = []
  end

  def order(item)
    @order_items << item
  end

  def cash_out
    discount? ? ((1-DISCOUNT_RATE) * sub_total).ceil.to_i : sub_total
  end

  def sub_total
    @order_items.map(&:price).inject(:+)
  end

  def item_total(type)
    @order_items.select { |item| item == type }.map(&:price).inject(:+)
  end

  def tax
    (cash_out * TAX_RATE).ceil.to_i
  end

  def payment(amount)
    @payment = amount
  end

  def change
    @payment - cash_out
  end

  def discount?
    sub_total > DISCOUNT_VALUE
  end

  def muffins?
    @order_items.map(&:name).any? { |s| s.include?('muffin') }
  end
end
