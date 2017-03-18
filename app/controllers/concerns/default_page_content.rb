module DefaultPageContent
  extend ActiveSupport::Concern
  
  included do
    before_filter :set_page_defaults
  end
  
  def set_page_defaults
    @page_title = "Charles Wooley's Portfolio"
    @seo_keywords = "Charles Wooley Portfolio"
  end
  
end