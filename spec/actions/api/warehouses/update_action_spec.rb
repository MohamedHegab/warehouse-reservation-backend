require 'rails_helper'

RSpec.describe Api::Warehouses::UpdateAction do
  let!(:warehouse) { create(:warehouse) }
  let(:name) { 'Name' }
  let(:params) do
    {
      id: warehouse.id,
      name:
    }
  end

  subject { described_class.new.call(params) }

  context 'valid params' do
    it { expect(subject).to be_success }
    it { expect(subject.value!.name).to eq name }
  end

  context 'not valid params' do
    let(:params) do
      {
        name: nil
      }
    end

    it { expect(subject).not_to be_success }
  end
end
