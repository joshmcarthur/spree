Given /^preference settings exist$/ do
  @configuration ||= AppConfiguration.find_or_create_by_name("Default configuration")
  Preference.create(:name => 'allow_ssl_in_production', :owner => @configuration, :value => '1')
  Preference.create(:name => 'site_url', :owner => @configuration, :value => "demo.spreecommerce.com")
  Preference.create(:name => 'allow_ssl_in_development_and_test', :owner => @configuration, :value => "0")
  Preference.create(:name => 'site_name', :owner => @configuration, :value => "Spree Demo Site")
end

Given /^custom line items associated with products$/ do
  Order.all.each do |order|
    Factory(:line_item, :order => order)
  end
end

When /^I follow the first admin_edit_order link$/ do
  order = Order.order('completed_at desc').first
  title = "admin_edit_order_#{order.id}"
  click_link(title)
end

Given /^the custom address exists for the given orders$/ do
  orders = Order.order('id asc').all
  raise 'there should be only three ordres' unless Order.count == 3

  o = orders[0]
  address = Factory(:address, :firstname => 'john')
  o.bill_address = address
  o.ship_address = address
  o.save

  o = orders[1]
  address = Factory(:address, :firstname => 'john')
  address = Factory(:address, :firstname => 'mary')
  o.bill_address = address
  o.ship_address = address
  o.save

  o = orders[2]
  address = Factory(:address, :firstname => 'angelina')
  o.bill_address = address
  o.ship_address = address
  o.save
end
