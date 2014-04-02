class PostsController < ApplicationController
 http_basic_authenticate_with :name=> "test", :password=> "test", :except=> [:index, :show]
def new 
  @post = Post.new
end

def index
  @posts = Post.all
end

def create
@post = Post.new(params[:post].permit(:title, :text))

  if @post.save
    redirect_to @post
  else
    render 'new'
  end
end

def show
  @post = Post.find(params[:id])
  
end

def edit
  @post = Post.find(params[:id])
end

def update
  @post = Post.find(params[:id])

  if @post.update(params[:post].permit(:title, :text))
    redirect_to @post
  else 
    render 'edit'
  end
end

def destroy
  @post = Post.find(params[:id])
  begin
  @post.destroy
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end
  redirect_to posts_path
end

 def upload
   uploaded_io = params[:person][:picture]
   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
     file.write(uploaded_io.read)
   end
 end


private
 def post_params
  params.require(:post).permit(:title, :text)
 end

end
