require 'rails_helper'

RSpec.describe Api::Warehouses::CreateAction do
  let(:params) do
    {
      name: 'Name'
    }
  end
  subject { described_class.new.call(params) }

  context 'valid params' do
    it { expect(subject).to be_success }
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
