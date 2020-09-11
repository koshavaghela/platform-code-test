class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_award_quality
    case name
    when 'Blue Distinction Plus'
      @quality = 80
    when 'NORMAL ITEM'
      self.normal_item
    when 'Blue First'
      self.blue_first
    when 'Blue Compare'
      self.blue_compare
    when 'Blue Star'
      self.blue_star
    end

    @expires_in -= 1 if name != 'Blue Distinction Plus'
  end

  private

  def normal_item
    if @quality.positive?
      self.has_expired? ? @quality -= 2 : @quality -= 1
    end
  end

  def blue_star
    self.has_expired? ? @quality -= 4 :  @quality -= 2
    @quality = 0 if @quality.negative?
  end

  def blue_first
    self.has_expired? ? @quality += 2 : @quality += 1
    @quality = 50 if @quality > 50
  end

  def blue_compare
    if self.has_expired?
      @quality = 0
    elsif @expires_in <= 5
      @quality += 3
    elsif (6..10).include?(@expires_in)
      @quality += 2
    elsif @expires_in > 10
      @quality += 1
    end

    @quality = 50 if @quality > 50
  end

  def has_expired?
    @expires_in <= 0
  end
end
