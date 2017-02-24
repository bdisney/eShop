class ContactMailer < ApplicationMailer

  def received(contact)
    @contact = contact

    mail to: contact.email, subject: 'Just Watches Store. Your message was received.'
  end
end
