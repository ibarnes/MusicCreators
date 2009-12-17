class Avatar < ActiveRecord::Base
   has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => 1500.kilobytes,
                 :resize_to => '110x110>',
                 :thumbnails => { :thumb => '80x80>' },
                 :processor => 'Rmagick'
 belongs_to :user
 def validate
    errors.add_to_base("You must choose a file to upload") unless self.filename

    unless self.filename == nil

      # Images should only be GIF, JPEG, or PNG
      [:content_type].each do |attr_name|
        enum = attachment_options[attr_name]
        unless enum.nil? || enum.include?(send(attr_name))
          errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
        end
      end

      # Images should be less than 5 MB
      [:size].each do |attr_name|
        enum = attachment_options[attr_name]
        unless enum.nil? || enum.include?(send(attr_name))
          errors.add_to_base("Images should be smaller than 5 MB in size")
        end
      end

    end
  end


 

end