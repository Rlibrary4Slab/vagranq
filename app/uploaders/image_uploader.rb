# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   include CarrierWave::RMagick
   #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
   #if Rails.env == "development" 
    #storage :file
   #elsif Rails.env == "production"
    storage :fog
   #end
  
  #def fog_attributes
  #  {
      #'Content-Type' =>  'image/jpg',
      #'Cache-Control' => "max-age=#{1.week.to_i}"
  #  }
  #end

  # Override the directory where uploaded files will be stored.


  
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "s1/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #"/sample-image/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fill => [40, 40, gravity = ::Magick::CenterGravity]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
  #process :resize_to_fill => [30, 30, gravity = ::Magick::CenterGravity]
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  # 画像の上限を200pxにする
  #process :resize_to_limit => [200, 200]

  # 保存形式をJPGにする
  process :convert => 'jpg'
  
  version :large do
   resize_to_limit(600,600)
  end
   #サムネイルを生成する設定
  version :thumb do
   process :crop
   resize_to_fill(40,40)
   #process :resize_to_fit => [40, 40]
  end
  version :thumb_view do
   process :crop
   resize_to_fill(50,50)
   #process :resize_to_fill => [50, 50, gravity = ::Magick::CenterGravity]
   #process :resize_to_fit => [40, 40]
  end
  

  
  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    #%w(jpg jpeg gif png)
    %w(jpg jpeg png)
  end

 # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
    #if original_filename.present?
    #  "#{model.id}_#{secure_token}.#{file.extension}"
    #end
  end

  
  def default_url
      #ActionController::Base.helpers.asset_path(["image-1.jpg"].compact.join('_'))
     "thumb_thumb_illust-52.jpg"
     #"heart_0.png"
  end
  
  
  
  def crop
     if model.crop_x.present?
       resize_to_limit(600,600)
       manipulate! do |img|
        x= model.crop_x.to_i
        y= model.crop_y.to_i
        w= model.crop_w.to_i
        h= model.crop_h.to_i
        img.crop!(x,y,w,h)
       end
     end
  end
  protected


  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
