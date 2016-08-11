class UsuarioMailer < ApplicationMailer
	default from: "projetoheroku@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.usuario_mailer.newuser.subject
  #
  def newuser(user)
    @greeting = "Hi"
    @newuser = user
    @name = user.name

    mail to: @newuser.email, subject: "New user"
  end
end
