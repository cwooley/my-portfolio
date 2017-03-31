module BlogsHelper
  def gravatar_helper user
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 40
  end
  
  def blog_status_color blog
    
    if blog.draft?
      'color: grey'
    end
  end
  
  
end
