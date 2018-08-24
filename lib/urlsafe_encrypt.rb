def urlsafe_encrypt(text)
  (value = OpenSSL::Cipher.new('aes-128-cbc').send(:encrypt)).key = Digest::SHA256.digest(Rails.application.secrets.SELFIE_KEY)[0, 16]
  Base64.urlsafe_encode64(value.update(text.to_s) << value.final).tr('=', '')
end

def urlsafe_decrypt(text)
  text = text.ljust(24, '=')
  text = Base64.urlsafe_decode64(text)
  (value = OpenSSL::Cipher.new('aes-128-cbc').send(:decrypt)).key = Digest::SHA256.digest(Rails.application.secrets.SELFIE_KEY)[0, 16]
  value.update(text) << value.final
end
