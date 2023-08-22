class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = contact

    mail to: @user_id.email, subject: "お問い合わせの確認メール"
  end
end

