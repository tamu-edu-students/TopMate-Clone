class EmailSubmissionController < ApplicationController
    def send_email
        if isEmailAssociated(params[:"Email Address"])
            flash[:success] = 'Email to reset password has been sent!'
        else
            flash[:error] = 'This email is not associated with any user'
        end
        redirect_back(fallback_location: root_path)
    end

    def isEmailAssociated(email)
        if  User.exists?(email: email)
            user = User.find_by(email: email)
            PasswordMailer.with(user: user).reset.deliver_later
            generateResetSession(user)
            true
        else
            false
        end
    end

    def generateResetSession(user)
        puts "Generating reset session for user #{user.id}"
        session_token = SecureRandom.uuid
        ResetPasswordSession.create(user_id: user.id, session_token: session_token)
        session_token
    end
end
