require 'spec_helper'

RSpec.describe Spree::BaseHelper, type: :helper do
  before(:each) do
    mock_current_store
  end

  let(:variant) { create(:international_variant, price_currencies: %w[CHF EUR]) }

  describe '#display_original_price' do
    subject { helper.display_original_price(variant) }

    it { is_expected.to eql(helper.display_price(variant)) }
  end

  describe '#display_discount_percent' do
    subject { helper.display_discount_percent(variant) }

    before(:each) do
      expect(variant).to receive(:discount_percent_in).and_return(discount)
    end

    context 'when variant has a discount' do
      let(:discount) { 10 }
      it { is_expected.to eql('10% Off') }
    end

    context 'when variant has NO discount' do
      let(:discount) { 0 }
      it { is_expected.to eql('') }
    end
  end

  def mock_current_store
    helper.extend(Spree::Core::ControllerHelpers::Pricing)
    helper.extend(Spree::Core::ControllerHelpers::Store)
    allow(helper).to receive(:current_store).and_return(build_stubbed(:store))
  end
end
