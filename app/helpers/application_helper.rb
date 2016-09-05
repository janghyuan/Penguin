module ApplicationHelper
	def full_title page_title = ''
		base_title = "Shandong University of Technology"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
end
