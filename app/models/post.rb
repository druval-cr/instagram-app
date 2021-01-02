class Post < ApplicationRecord
    validates :caption, presence: true
    validates :image, presence: true

    has_attached_file :image, styles: { :large => "855x570>", :medium => "432x288>", :small => "276x184>" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
