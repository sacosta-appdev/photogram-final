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

end
