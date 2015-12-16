require 'nokogiri'
require 'open-uri'
require 'json'


class Category < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	def self.crawl
		@categories = Category.all
		@categories.each do |category|
			if category.is_crawl == "true"
				articles_links = Nokogiri::HTML(open('http://9gag.com/' + category.name))
				articles_links.xpath('//article/@data-entry-url').each do |link|
					article = Nokogiri::HTML(open(link))
					article_id = (link.text).rpartition('/').last

					title = article.xpath('//header/h2').text

					point_of_article = "a#love-count-" + article_id + "span span.badge-item-love-count"
					point = article.css(point_of_article).text

					idx=0
					image_url = article.xpath('//img').first['src']
					post = Post.create(category_id: category.id,title: title,image_url: image_url,point: point)

					comment_url = "http://d8d94e0wul1nb.cloudfront.net/comment?callback=comment_list&appId=a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b&url=http%3A%2F%2F9gag.com%2Fgag%2F" + article_id + "&order=score&count=10&level=2&ref=&refCommentId=&commentId="  
      		result = Net::HTTP.get(URI.parse(comment_url))
       		comment_json_data = result[13..result.length-3]

		       comment_data = JSON.parse(comment_json_data)
		       comment_list = comment_data["payload"]["comments"]

		       comment_list.each do |comment|
		         name = comment["commentId"]
		         body = comment["text"]
		         post_id = post.id

		         Comment.create(post_id: post_id,name: name, body: body)
		      end    
				end
			end
		end
	end
end
