# frozen_string_literal: true

class ImageOptimizer
  attr_reader :image

  def initialize(url: nil, image: nil)
    @image = image || image_from_url(url)
  end

  def optimized_image
    image.quality('90').resize('300x300')

    image_file
  end

  private

  def image_file
    image.tempfile.open
  end

  def image_from_url(url)
    MiniMagick::Image.open(url)
  end
end
