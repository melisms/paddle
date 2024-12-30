# app/services/feed.rb
class Feed
  def initialize(user)
    @user = user
  end

  def fetch_feed
    # Generate a unique cache key for the feed
    cache_key = "user_feed_#{@user.id}"

    # Fetch the feed from the cache or generate it
    Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      # Get the IDs of users the current user follows
      followed_user_ids = @user.followed_users.pluck(:id) << @user.id

      # Get posts from the followed users (including the current user)
      followed_posts = Post.where(user_id: followed_user_ids).order(created_at: :desc)

      # Optionally, get some random posts from users who are not the current user
      random_posts = Post.where.not(user_id: @user.id).order("RANDOM()").limit(5)

      # Combine the posts from followed users and random posts
      combined_posts = (followed_posts + random_posts).sort_by(&:created_at).reverse

      # Return the final feed
      combined_posts
    end
  end
end
