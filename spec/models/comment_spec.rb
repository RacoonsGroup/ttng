require 'rails_helper'

describe Comment do
  let!(:encrypted_info) { FactoryGirl.create(:comment, encrypted: true, info: 'content'.encrypt(:symmetric, password: 'key')) }
  let!(:info) { FactoryGirl.create(:comment, info: 'content') }

  describe '#decrypted_info' do
    context 'for encrypted info' do
      context 'with valid key' do
        it 'returns encrypted info' do
          expect(encrypted_info.decrypted_info('key')).to eq('content')
        end
      end

      context 'with invalid key' do
        it 'raises exception' do
          expect{encrypted_info.decrypted_info('wrong_key')}.to raise_error(OpenSSL::Cipher::CipherError)
        end
      end
    end

    context 'for not crypted info' do
      it 'returns info' do
        expect(info.decrypted_info()).to eq('content')
      end
    end
  end
end
