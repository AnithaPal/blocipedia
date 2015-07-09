class AuthMailer < ActionMailer::Base
  
  def test(to, body="testing 123")
    @to = to
    @body = body
    mail(from: 'test@test.com', to: to, subject: 'test')
  end

  def forgot_password(user)

  end
end