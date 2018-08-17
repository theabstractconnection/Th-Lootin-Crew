class PhotoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :card do
    cloudinary_transformation gravity: :auto, width: 256, height: 256, crop: :fill
  end

  version :card_wide do
    cloudinary_transformation gravity: :auto, width: 1200, height: 400, crop: :fill
  end

  version :avatar do
    cloudinary_transformation  gravity: :auto, effect: "brightness:30", radius: 20,
      width: 150, height: 150, crop: :thumb, gravity: :face
  end

end
