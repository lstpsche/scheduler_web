# frozen_string_literal: true

module DeviseCustom
  class SessionsController < Devise::SessionsController
    # DELETE /sign_out
    def destroy
      super
      flash.delete(:notice)
    end
  end
end
