class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def sign_in_and_redirect(resource_or_scope, *args)
      #可変長引数(args)配列からハッシュと取り出す。
      options  = args.extract_options!
      scope    = Devise::Mapping.find_scope!(resource_or_scope)
      resource = args.last || resource_or_scope
      sign_in(scope, resource, options)
    #   redirect_to after_sign_in_path_for(resource)
      redirect_to edit_user_registration_path(resource)
      
      # logger.debug("-----------可変長引数#{args.extract_options!}")
      # logger.debug("-----------resource_or_scope#{resource_or_scope.inspect}")
      # logger.debug("------------options#{options}")
      # logger.debug("------------scope#{scope}")
      # logger.debug("-----------resource#{resource.inspect}")
      
  end
  
  
  def sns_registration_and_redirect(resource_or_scope, *args)
      options  = args.extract_options!
      scope    = Devise::Mapping.find_scope!(resource_or_scope)
      resource = args.last || resource_or_scope
      sign_in(scope, resource, options)
      redirect_to user_path(resource)
  end
  
end
