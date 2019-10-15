# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'invitations@infinite-taiga.com'
  layout 'mailer'
end
