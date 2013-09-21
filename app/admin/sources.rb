ActiveAdmin.register Source do
  index do
    column :name
    column "Logo"do |post|
      link_to image_tag(post.logo, :width => 30, height: 30), post.url
    end
    column :image_in_content
    column :image_in_detail
    column :image_in_summary
    column :status
    default_actions
  end

  show do
    render "show"
  end

  form do |f|
    f.inputs "Main poll" do
      f.input :name
      f.input :logo
      f.input :url
      f.input :image_in_content
      f.input :image_in_summary
      f.input :image_in_detail
      f.input :status
    end

    f.inputs do
      f.has_many :feeds do |feed_builder|
        feed_builder.input :name
        feed_builder.input :url
        feed_builder.input :limit
        feed_builder.input :image
        feed_builder.input :image_in_detail
        feed_builder.input :status
      end
    end

    f.buttons
  end
end
