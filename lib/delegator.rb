require 'rubygems'
require 'restclient'

class Bakedweb
  class Delegator
    def self.envia(params)
      raise "WrongNumberOfParams" if params[:person][:nombre] == nil
      raise "WrongNumberOfParams" if params[:person][:telefono] == nil
      raise "WrongNumberOfParams" if params[:person][:email] == nil
      raise "WrongNumberOfParams" if params[:person][:account] == nil
      RestClient.post 'admin.bolsitosdecolores.com/people', params
    end
  end
end