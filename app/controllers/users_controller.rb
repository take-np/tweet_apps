class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :show, :update, :index]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    #@user = User.find_by(id: params[:id])
    # to_iメソッドを用いて、数値を文字列に変換しているが、上記で@userを取得すれば、数値型に取得できるはず
    if @current_user.id != params[:id].to_i
      # if @user.id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpeg",
      password: params[:password]
      )
    @user.save
    # 最初の特録段階で、画像を保存するようにしたいのだけれど、その設定にすると、default_image.jepgであっても、ファイル名がidと一致してしまう。それでも大丈夫なのか？＞
    # if @user.image_name
      @user.image_name = "#{@user.id}.jpg"
    #   image = params[:image]
    #   File.binwrite("#{@user.id}.jpg", image.read)
    # end

    if @user.save
      sesson[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.image_name
      @user.image_name = "aaa"
      image = params[:image]
      File.binwrite("public/@user.image_name", image.read)
    end

    if @user.save
      flash[:notice] = "更新が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form

  end
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスとパスワードが一致しません"
      #バリデーションエラーではないので、自分でエラーの場合にはメッセージが表示されるようにする
      @email = params[:email]
      @password = params[:email]
      # 一致しない場合に、フォームに入力した値が、初期値となるように設定
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
