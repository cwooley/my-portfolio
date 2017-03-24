module ApplicationHelper
  
  def login_helper(style = '')
    if current_user.is_a?(GuestUser)
      (link_to "Sign in", new_user_session_path, class: style) + " " +
      (link_to "Register", new_user_registration_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    end 
  end
  
  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]}"
      content_tag(:p,
                  greeting,
                  class: "source-greeting"
                  )
    end
  end
  
  def copyright_generator()
    MammothViewTool::Renderer.copyright 'Charles Wooley', 'All Rights Reserved'
  end
  
  def nav_items
    [
      {
        path: root_path,
        title: 'Home'
      },
      {
        path: about_path,
        title: 'About'
      },
      {
        path: contact_path,
        title: 'Contact'
      },
      {
        path: blogs_path,
        title: 'Blog'
      },
      {
        path: portfolios_path,
        title: 'Portfolio'
      },
    ]
  end
  
  
  def nav_helper style, tag_type
    nav_links = ''
    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:path]}'class='#{style} #{active? item[:path]}'>#{item[:title]}</a></#{tag_type}>"
    end
    
    nav_links.html_safe
  end
  
  def active? path
    "active" if current_page? path
  end
end
