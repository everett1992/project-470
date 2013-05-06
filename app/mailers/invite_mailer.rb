class InviteMailer < ActionMailer::Base
	# TODO: change this to an app email address, something other than mine
  default from: "everett.caleb@gmail.com"

  def invite(invite, join_url)
    @dwelling = invite.dwelling
    @join_url = join_url
    puts mail( to: invite.email, subject: "You have been invited to join #{@dwelling.name} on Roomie")
  end
end
