require 'open-uri'
require 'nokogiri'
module Johnny5
	class Base
		LIST_OF_BAD_WORDS = %w{trend gallery bar submit ads-inarticle sponsor shopping widget tool promo shoutbox masthead foot footnote combx com- menu side comments comment bookmarks social links ads related similar footer digg totop metadata sitesub nav sidebar commenting options addcomment leaderboard offscreen job prevlink prevnext navigation reply-link hide hidden sidebox archives vcard tab hyperpuff chicklets trackable advertisement email partners crumbs header share discussion popup _ad ad_ ad- -ad extra community disqus about signup feedback byline trackback login blogroll rss}.uniq
		TAGS_TO_EXAMINE = %w{div p table tr td pre tbody section ul ol li}
		TAGS_TO_REMOVE = %w{header footer nav script noscript form input}
		def initialize(url)
			@url = url
		end

		def read
			if @url.to_s.match(/(jpg|png|gif|jpeg|bmp|tiff)$/) # this is an image
				# return an image tag
			elsif @url.to_s.match(/(avi|mov|mpeg|flv)$/) # this is a movie
				# this is a movie, put it in an iframe or something...
			else
				# look for content
				html = Nokogiri::HTML(open(@url))
				trim_unwanted_tags(html)
				return html.to_s
			end
		end

		def trim_unwanted_tags(nokogiri_object)
			TAGS_TO_EXAMINE.each do |tag|
				LIST_OF_BAD_WORDS.each do |bad_word|
					 nokogiri_object.xpath("//#{tag}[contains(@class,\"#{bad_word}\")]").remove if !bad_word.blank? # we have to find a way to make this case insensetive 
					 nokogiri_object.xpath("//#{tag}[contains(@id,\"#{bad_word}\")]").remove if !bad_word.blank?
				end
				nokogiri_object.xpath("//#{tag}[contains(@style,\"hidden\")]").remove
			 end
			TAGS_TO_REMOVE.each do |tag|
				nokogiri_object.css("#{tag}").remove
			end

			# removes css/js that have local paths
			html.css('link').each do |header_object|
				header_object.remove if !header_object.attributes['href'].value.match(/http/)
			end

			# removes images that have local paths, tried including imgur (uses data-src)
			html.css('img').each do |image|
				image.remove unless image.attributes['src'].value.match(/http/) || image.attributes['data-src'].value.match(/http/)
			end

			return nokogiri_object
		end

		def get_main_content(nokogiri_object)
			# here we want to look at the biggest div and take its largest container
		end

		def get_title(nokogiri_object)
		end

		def get_author(nokogiri_object)
		end

		def get_tags(nokogiri_object)
		end
	end
end