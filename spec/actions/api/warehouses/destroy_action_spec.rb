require 'rails_helper'

RSpec.describe Api::Warehouses::DestroyAction do
  let!(:warehouse) { create(:warehouse) }
  let(:name) { 'Name' }
  let(:params) do
    {
      id: warehouse.id
    }
  end

  subject { described_class.new.call(params) }

  context 'valid params' do
    it { expect(subject).to be_success }
  end
end
