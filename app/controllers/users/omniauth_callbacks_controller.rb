# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  
  def facebook
    callback_from :facebook
  end

  #オリジナル
  # def callback_from(provider)

  #   provider = provider.to_s
    
  #   #FacebookからOmniAuthで取得したすべての情報はrequest.env["omniauth.auth"]のハッシュでアクセス
  #   @user = User.find_for_oauth(request.env['omniauth.auth'])
    
  #   if @user.persisted? #@userがDBに存在するなら、またはcreate（新規登録ができたか)
    
  #     #flashメッセージをする。providerの頭文字だけ大文字
  #     #lash messageにはdefaultのメッセージ
  #     flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
  #     sign_in_and_redirect @user, event: :authentication  #eventはuserがアクティブでないときにエラーを吐き出す。
      
  #   else
      
  #     #create（新規登録)ができていなかった場合はsessionに取得したfasebookデータを入れる。画像遷移時に役立つ。
  #     #userがブラウザから離れるときはdevise.で始まるデータは全て削除される。
  #     session["devise.#{provider}_data"] = request.env['omniauth.auth'] #データを保持してログインへ飛ばす
  #     redirect_to new_user_registration_url
      
  #   end
  # end
  
  #アレンジ
  #fasebookからの情報を受け取る
  def callback_from(provider)
    provider = provider.to_s
    
    #コールバックメソッドを呼び出し
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    
    
    if @user   #登録済み
      #flashメッセージをする。providerの頭文字だけ大文字
      #lash messageにはdefaultのメッセージ
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sns_registration_and_redirect @user, event: :authentication  #eventはuserがアクティブでないときにエラーを吐き出す
      
    else #未登録
      @user = User.create_for_oauth(request.env['omniauth.auth'])
      #flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      #user編集へ
      sign_in_and_redirect @user, event: :authentication  #eventはuserがアクティブでないときにエラーを吐き出す
             
    end
    
    unless @user.persisted?    #@userがDBに存在するなら、またはcreate（新規登録ができたか)
      #create（新規登録)ができていなかった場合はsessionに取得したfasebookデータを入れる。画像遷移時に役立つ。
      #userがブラウザから離れるときはdevise.で始まるデータは全て削除される。
      session["devise.#{provider}_data"] = request.env['omniauth.auth']   #データを保持してログインへ飛ばす
      redirect_to new_user_registration_url
    end
    
  end




  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
   def failure
     super
   end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
