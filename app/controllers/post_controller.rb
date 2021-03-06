class PostController < ApplicationController
    before_action :configure_permitted_parameters, :authenticate_user!, if: :devise_controller?

    def index
        if(user_signed_in?)
            @post_data = Post.all.order("created_at DESC");
        else
            #render :new_user_session
        end
        #p @post_data
    end

    def new
        #@post = Post.new
        #@post = (Post.new) 
    end

    def create
        if(user_signed_in?)
            @post_data = Post.new(post_params)
            if @post_data.save
                redirect_to posts_path
                #redirect_to post_index_path
            else
                render :new
            end
        else
            render :new_user_session
        end
    end

    def show
        @post_single_data = Post.find(params[:id]);
    end

    def edit
        # p params[:id]
        @post_edit_data = Post.find(params[:id]);

        Rails.logger.debug("My object: #{@post_edit_data.inspect}");
    end

    def update
        @post_update_data = Post.find(params[:id]);

        if @post_update_data.update(post_params)
            redirect_to posts_path
            #redirect_to post_index_path
        else
            render :new
        end
    end

    def destroy
        @post_delete_data = Post.find(params[:id]);
        @post_delete_data.destroy

        redirect_to posts_path
        #redirect_to post_index_path
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in) do |user_params|
            user_params.permit(:username, :email)
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
        end
    end

    private
    def post_params
        params.required(:post).permit(:title, :body)
    end
end