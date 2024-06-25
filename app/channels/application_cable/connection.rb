module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = User.find_by(id: session[:user_id])
    end

    def session
      @request.session
    end
  end
end
