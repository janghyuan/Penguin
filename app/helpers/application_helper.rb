module ApplicationHelper
	def full_title page_title = ''
		base_title = "Shandong University of Technology"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
	def gravatar_for user, options = {}
		size = options[:size] || 64
		style = options[:class] || ''
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar #{style}")
	end
end
