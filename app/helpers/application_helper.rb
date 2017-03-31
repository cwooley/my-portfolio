module ApplicationHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div if language
    end
  end
  
  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, 
                                  :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :lax_html_blocks => true,
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
  
  def login_helper(style = '')
    if current_user.is_a?(GuestUser)
      (link_to "Sign in", new_user_session_path, class: style) + " " +
      (link_to "Register", new_user_registration_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    end 
  end
  
  def source_helper(styles)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]}, please feel free to #{ link_to 'contact me', contact_path}, if you would like to work together."
      content_tag(:div, greeting.html_safe, class: styles )
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
  
  
  
  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Charles Wooley Portfolio", sticky: false)
  end
  
end
