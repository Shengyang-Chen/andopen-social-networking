require 'nokogiri'
require 'open-uri'

class SiteContentsController < ApplicationController
  def create
    # Scrap webpage content in HTML using Nokogiri based on valid URL of the associated member
    if params[:url]
      html_content = URI.open(params[:url])
      if html_content
        doc = Nokogiri::HTML(html_content)

        # Get all h1-h3 headings in the specific page and store as SiteContent active records, "h1/h2/h3" as type and the actual heading value as context value
        doc.css('h1', 'h2', 'h3').each do |element|
          @site_content = SiteContent.new(:type => element.name, :context => element.text)
          @site_content.save
        end
      end
    end
  end
end
