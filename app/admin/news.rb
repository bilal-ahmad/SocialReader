ActiveAdmin.register News do
  index do
    column "Logo"do |text|
      text.length > 140 ? (text.slice(0..140)+"...") : text
    end
    default_actions
  end

end
