class UserController < ApplicationController

  #
#  id                             :integer          not null, primary key
#  comments_count                 :integer
#  email                          :string
#  likes_count                    :integer
#  own_photos_count               :integer
#  password_digest                :string
#  private                        :boolean
#  received_follow_requests_count :integer
#  sent_follow_requests_count     :integer
#  username                       :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null

  def index
    user_list = User.all
    @display_user_list = user_list.order({ :username => :asc })

    render({ :template => "user/index.html.erb" })

  end

  def user_details

    @username = params.fetch("username")
    @user = User.where({ :username => @username })[0]
    @user_pending_requests = @user.received_follow_requests.where({ :status => "pending"})

    if session.fetch(:user_id) == nil
      redirect_to("/user_sign_in", { :alert => "You have to sign in first." })
    else
      if @user.private == true
        redirect_to("/", { :alert => "You're not authorized for that." })
      else 
        render({ :template => "user/user_details.html.erb"})
      end
    end

  end

  def user_feed

    @username = params.fetch("username")
    @user = User.where({ :username => @username })[0]
    follow_requests = FollowRequest.where({ :recipient_id => @user.id })
    @followers = follow_requests.where({ :status => "accepted" })

    sent_requests = FollowRequest.where({ :sender_id => @user.id })
    @following = sent_requests.where({ :status => "accepted" })



    render({ :template => "/user/user_feed.html.erb" })

  end

end
