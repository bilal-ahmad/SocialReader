class Source < ActiveRecord::Base
  attr_accessible :logo, :name, :status, :url, :image_in_detail, :image_in_summary, :image_in_content, :feeds_attributes

  has_one :news
  has_many :feeds
  accepts_nested_attributes_for :feeds , :reject_if => proc { |attributes| attributes['url'].blank? }

  def self.get_image_and_content(options)
    image = get_image
    if image
      options[:content].present?
      image =  Hpricot(options[:content]).search('img').present? ? Hpricot(options[:content]).search("img").first.attributes['src'] : nil if image.blank? and options[:content].present?
      content = options[:content].present? ? options[:content] : options[:summary]
    elsif options[:url].present?
      doc = open(options[:url]) { |f| Hpricot f, :fixup_tags => true }

      if (doc/"#articleImage").present? or (doc/"#articleText")

        image =  (doc/"#articleImage/img").first.attributes['src'] if (doc/"#articleImage").present?
        content = (doc/"#articleText").inner_html if (doc/"#articleText").present?

      elsif (doc/".entry-content").present?

        image =  (doc/"#ap-smallphoto-table/img").first.attributes['src'] if (doc/"#ap-smallphoto-table/img").present?
        content = (doc/".entry-content").inner_html if (doc/".entry-content").present?

      end
    end
    content_and_image = {:content => content, :image => image}
  end

  def get_image(options)
      image = (options[:summary].present? and Hpricot(options[:summary]).search('img').present?) ? Hpricot(options[:summary]).search('img').first.attributes['src'] : nil
      image = (options[:content].present? and Hpricot(options[:content]).search('img').present?) ? Hpricot(options[:content]).search('img').first.attributes['src'] : nil
  end

  def get_image_from_summary

  end

end
