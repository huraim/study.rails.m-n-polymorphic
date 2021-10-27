class HomeController < ApplicationController

  def index
    @categories = Category.all
  end

  # 게시글, 댓글 좋아요 START -----

  def add_like 
    @like = Likes.all

  end


  # 게시글, 댓글 좋아요 END -----

  def category_show
    #@posts = Post.all
    @category = Category.find(params[:category_id])
  end

  def category_modify
    @category = Category.find(params[:category_id])
  end

  def category_update
    category = Category.find(params[:category_id])
    category.title = params[:title]
    category.save

    redirect_to '/'
  end

  def category_write

  end

  def category_delete
    category = Category.find(params[:category_id])
    category.destroy

    redirect_to '/'
  end

  def category_create
    category = Category.new
    category.title = params[:title]
    category.user_id = current_user.id
    category.save

    redirect_to '/'
  end

  def write
    @category = Category.find(params[:category_id])
  end

  def create
    if user_signed_in?
      post = Post.new
      post.user_id = current_user.id
      post.category_id = params[:category_id]
      post.title = params[:title]
      post.content = params[:content]
      post.is_privacy = true
      post.save
  
      redirect_to "/category_show/#{post.category.id}"
    else
      redirect_back(fallback_location: '/')
    end
  end

  def privacy_update
    post = Post.find(params[:post_id])
    
    # if post.is_privacy == true
    #   post.is_privacy = false
    #   post.save
    # elsif post.is_privacy == false
    #   post.is_privacy = true
    #   post.save
    # end
    authenticate_my_post!(post) rescue return redirect_back(fallback_location: '/')
    post.is_privacy = !post.is_privacy
    post.save

    redirect_back(fallback_location: '/')
  end

  def modify
    # if current_user.id == @check.user.id
      @post = Post.find(params[:post_id])
      authenticate_my_post!(@post)
    # else
    #   redirect_back(fallback_location: '/')
    # end
  end

  def update
    post = Post.find(params[:post_id])
    #authenticate_my_post!(post) rescue return redirect_back(fallback_location: '/')
    post.user_id = current_user.id
    post.title = params[:title]
    post.content = params[:content]
    post.save

    redirect_to "/category_show/#{post.category.id}"
  end

  def delete
    post = Post.find(params[:post_id])
    # if current_user.id == @check.user.id
    #authenticate_my_post!(post) rescue return redirect_back(fallback_location: '/')
    post.destroy
    redirect_back(fallback_location: '/')
    # else
      # redirect_back(fallback_location: '/')
    # end
  end

  def reply_create
    if user_signed_in?
      reply = Reply.new
      reply.post_id = params[:post_id]
      reply.content = params[:content]
      reply.user_id = current_user.id
      reply.save
  
      redirect_back(fallback_location: '/')
    else
      flash[:notice] = '로그인이 필요합니다'
      redirect_to '/'
    end
  end

  def reply_delete
    reply = Reply.find(params[:reply_id])
    # if current_user.id == @check.user.id
    #authenticate_my_post!(reply) rescue return redirect_back(fallback_location: '/')
      reply.destroy
      redirect_back(fallback_location: '/')
    # else 
    #   redirect_back(fallback_location: '/')
    # end
  end

  def reply_modify_form
    @reply = Reply.find(params[:reply_id])
    authenticate_my_post!(@reply)
  end

  def reply_update
    reply = Reply.find(params[:reply_id])
    #authenticate_my_post!(reply) rescue return redirect_back(fallback_location: '/')
    reply.content = params[:content]
    reply.save

    redirect_to "/category_show/#{reply.post.category.id}"
  end

  private

  def authenticate_my_post!(resource)
    if current_user.id != resource.user.id
      raise Error
    end
  end

end
