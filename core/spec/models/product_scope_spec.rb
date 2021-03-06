require File.dirname(__FILE__) + '/../spec_helper'

describe ProductScope do

  context "validations" do
    #it { should have_valid_factory(:product_scope) }
  end

  # FIXME use factory in the following test
  context "#check_validity_of_scope" do
    before do
      @pg = Factory(:product_group)
      @ps = ProductScope.create(:name => 'in_name', :arguments => ['Rails'], :product_group_id => @pg.id)
    end
    it 'should be valid' do
      @pg.valid?.should be_true
    end

  end

end
