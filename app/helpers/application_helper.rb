module ApplicationHelper
  def full_title(page_title = '') #Returns page title 
    base_title = "railstutorial"
      if page_title.empty?
        base_title
      else
        page_title + " - " + base_title
      end
    end
end
