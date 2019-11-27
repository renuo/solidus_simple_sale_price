require 'spec_helper'

describe Spree::Price do
  let(:instance) { build(:price) }

  describe '#original_amount' do
    it 'keeps track of the old price' do
      expect { instance.amount = 1.00 }.to change { instance.original_amount }.to(1.00)
    end

    it 'sets the amount attribute' do
      expect { instance.original_amount = 2.00 }.to change { instance.amount }.to(2.00)
    end
  end

  context 'when there is a sale price amount' do
    let(:instance) { build(:price, amount: 18.48, sale_amount: 17.89) }

    describe '#original_amount' do
      subject { instance.original_amount }
      it { is_expected.not_to eq(instance.sale_amount) }
    end

    describe '#amount' do
      subject { instance.amount }
      it { is_expected.to eq(instance.sale_amount) }
    end

    describe '#on_sale?' do
      subject { instance.on_sale? }
      it { is_expected.to be_truthy }
    end

    describe '#discount_percent' do
      subject { instance.discount_percent }
      it { is_expected.to be_within(0.05).of(3.2) }
    end

    context 'when there is no amount' do
      let(:instance) { build(:price, amount: nil, sale_amount: 12.0) }

      describe '#on_sale?' do
        subject { instance.on_sale? }

        it { is_expected.to be false }
      end
    end
  end

  context 'when there is NO sale price amount' do
    let(:instance) { build(:price, amount: 18.48, sale_amount: nil) }

    describe '#original_amount' do
      subject { instance.amount }
      it { is_expected.not_to eq(instance.sale_amount) }
    end

    describe '#amount' do
      subject { instance.amount }
      it { is_expected.to eq(instance.original_amount) }
    end

    describe '#on_sale?' do
      subject { instance.on_sale? }
      it { is_expected.to be_falsey }
    end

    describe '#discount_percent' do
      subject { instance.discount_percent }
      it { is_expected.to eq(0.0) }
    end
  end
end
