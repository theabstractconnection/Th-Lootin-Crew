class PhotoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :card do
    resize_to_fit 256, 256
  end

  version :card_wide do
    cloudinary_transformation gravity: :center, width: 800, height: 800, crop: :fill
  end

  version :avatar do
    cloudinary_transformation effect: "brightness:30", radius: 20,
      width: 150, height: 150, crop: :thumb, gravity: :face
  end

end
