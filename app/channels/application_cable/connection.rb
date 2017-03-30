module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def guest_user
      guest = GuestUser.new
      guest.id = guest.object_id
      guest.email = "actionguest@gmail.com"
      guest.first_name = "Actionguest"
      guest.last_name = "Cableguest"
      guest
    end
    
    def connect
      self.current_user = find_verified_user || guest
      logger.add_tags 'ActionCable', current_user.email
      logger.add_tags 'ActionCable', current_user.id
    end
    
    protected
    
    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      end
    end
    
  end
end
