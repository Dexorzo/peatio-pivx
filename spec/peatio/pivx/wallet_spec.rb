RSpec.describe Peatio::Pivx::Wallet do
  let(:wallet) { Peatio::Pivx::Wallet.new }

  let(:uri) { 'http://admin:changeme@127.0.0.1:51475' }
  let(:uri_without_authority) { 'http://127.0.0.1:51475' }

  let(:settings) do
    {
      wallet: { address: 'something',
                uri:     uri },
      currency: { id: :pivx,
                  base_factor: 100_000_000,
                  options: {} }
    }
  end

  before { wallet.configure(settings) }

  context :configure do
    let(:unconfigured_wallet) { Peatio::Pivx::Wallet.new }

    it 'requires wallet' do
      expect{ unconfigured_wallet.configure(settings.except(:wallet)) }.to raise_error(Peatio::Wallet::MissingSettingError)

      expect{ unconfigured_wallet.configure(settings) }.to_not raise_error
    end

    it 'requires currency' do
      expect{ unconfigured_wallet.configure(settings.except(:currency)) }.to raise_error(Peatio::Wallet::MissingSettingError)

      expect{ unconfigured_wallet.configure(settings) }.to_not raise_error
    end

    it 'sets settings attribute' do
      unconfigured_wallet.configure(settings)
      expect(unconfigured_wallet.settings).to eq(settings.slice(*Peatio::Pivx::Wallet::SUPPORTED_SETTINGS))
    end
  end

  context :create_address! do
    before(:all) { WebMock.disable_net_connect! }
    after(:all)  { WebMock.allow_net_connect! }

    let(:response) do
      response_file
        .yield_self { |file_path| File.open(file_path) }
        .yield_self { |file| JSON.load(file) }
    end

    let(:response_file) do
      File.join('spec', 'resources', 'getnewaddress', 'bda40f63c61d76463e5c5ca8750c8f711d7f8fc0735b1c629e06fc3e76ce2c4e.json')
    end

    before do
      stub_request(:post, uri_without_authority)
        .with(body: { jsonrpc: '1.0',
                      method: :getnewaddress,
                      params:  [] }.to_json)
        .to_return(body: response.to_json)
    end

    it 'request rpc and creates new address' do
      result = wallet.create_address!(uid: 'UID123')
      expect(result.symbolize_keys).to eq(address: 'xzSCark5FXGWn96WCZE4sctCFQ5TonhmjD')
    end
  end

  context :create_transaction! do
    before(:all) { WebMock.disable_net_connect! }
    after(:all)  { WebMock.allow_net_connect! }

    let(:response) do
      response_file
        .yield_self { |file_path| File.open(file_path) }
        .yield_self { |file| JSON.load(file) }
    end

    let(:response_file) do
      File.join('spec', 'resources', 'sendtoaddress', 'bda40f63c61d76463e5c5ca8750c8f711d7f8fc0735b1c629e06fc3e76ce2c4e.json')
    end

    before do
      stub_request(:post, uri_without_authority)
        .with(body: { jsonrpc: '1.0',
                      method: :sendtoaddress,
                      params:  [transaction.to_address,
                                transaction.amount,
                                '',
                                '',
                                false] }.to_json)
        .to_return(body: response.to_json)
    end

    let(:transaction) do
      Peatio::Transaction.new(amount: 0.11, to_address: 'xzSCark5FXGWn96WCZE4sctCFQ5TonhmjD')
    end

    it 'requests rpc and sends transaction without subtract fees' do
      result = wallet.create_transaction!(transaction)
      expect(result.amount).to eq(0.11)
      expect(result.to_address).to eq('xzSCark5FXGWn96WCZE4sctCFQ5TonhmjD')
      expect(result.hash).to eq('1c5eb9dc533c369876b62f0b0bf8d69860473bb08e312316faf0ce35f2126fd7')
    end
  end

  context :load_balance! do
    before(:all) { WebMock.disable_net_connect! }
    after(:all)  { WebMock.allow_net_connect! }

    let(:response) do
      response_file
        .yield_self { |file_path| File.open(file_path) }
        .yield_self { |file| JSON.load(file) }
    end

    let(:response_file) do
      File.join('spec', 'resources', 'getbalance', 'bda40f63c61d76463e5c5ca8750c8f711d7f8fc0735b1c629e06fc3e76ce2c4e.json')
    end

    before do
      stub_request(:post, uri_without_authority)
        .with(body: { jsonrpc: '1.0',
                      method: :getbalance,
                      params:  [] }.to_json)
        .to_return(body: response.to_json)
    end

    it 'requests rpc with getbalance call' do
      result = wallet.load_balance!
      expect(result).to be_a(BigDecimal)
      expect(result).to eq('6.00001982'.to_d)
    end
  end
end
