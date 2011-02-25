module BlogpostsHelper
  
  def format_average_rating average_rating
     return average_rating ? number_with_precision(average_rating, :precision => 1) << " / 5.0" : "Unrated. Be the first to rate!"
  end
  
  def format_count_of_ratings count_of_ratings
    return "" if count_of_ratings == 0
    return count_of_ratings > 1 ? "(" << count_of_ratings.to_s << " ratings)" : "(" << count_of_ratings.to_s << " rating)"
  end
  
end
