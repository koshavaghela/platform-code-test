require 'award'

def update_quality(awards)
  awards.map(&:update_award_quality)
end
