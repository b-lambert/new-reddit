before_filter :load_commentable
before_filter :get_post

def get_post
  @post = Post.find(params[:post_id])
end

def create
  @comment = @commentable.comments.build(params[:comment])
  @comment.user = current_user
  respond_to do |format|
    if @comment.save
      format.html { redirect_to @commentable }
    else
      format.html { render :action => 'new' }
    end
  end
end
def index
  @commentable = find_commentable
  @comments = @commentable.comments
end

private

def find_commentable
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
end

def load_commentable
  @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
end
