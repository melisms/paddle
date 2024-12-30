
class Feed
  def initialize(user)
    @user = user
  end

  def fetch_feed
    cache_key = "user_feed_#{@user.id}"


    Rails.cache.fetch(cache_key, expires_in: 10.minutes) do

      followed_user_ids = @user.followed_users.pluck(:id) << @user.id

      followed_posts = Post.where(user_id: followed_user_ids).order(created_at: :desc)

      random_posts = Post.where.not(user_id: @user.id).order("RANDOM()").limit(5)

      combined_posts = (followed_posts + random_posts).sort_by(&:created_at).reverse

      combined_posts
    end
  end
end
