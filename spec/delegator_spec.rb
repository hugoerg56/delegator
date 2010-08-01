require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'spec'
require 'rubygems'
require 'fakeweb'
require 'delegator'

FakeWeb.register_uri(:get, "admin.bolsitosdecolores.com/people.json", :body => "success")


describe Bakedweb do
  
  describe "Raising exceptions" do 
    it "should not send request without nombre" do
      params = {:person => { :email => "ivan@bakedweb.net", :phone => "3057737020"} }
      lambda { Bakedweb::Delegator.envia(params) }.should raise_exception("WrongNumberOfParams")
    end
  
    it "should not send request without telefono" do
      params = {:person => { :email => "ivan@bakedweb.net", :nombre => "Ivan"} }
      lambda { Bakedweb::Delegator.envia(params) }.should raise_exception("WrongNumberOfParams")
    end
  
    it "should not send request without email" do
      params = {:person => { :telefono => "3057737020", :nombre => "Ivan"} }
      lambda { Bakedweb::Delegator.envia(params) }.should raise_exception("WrongNumberOfParams")
    end
  
    it "should not send request without account" do
      params = {:person => { :email => "ivan@bakedweb.net", :telefono => "3057737020", :telefono => "3057737020"} }
      lambda { Bakedweb::Delegator.envia(params) }.should raise_exception("WrongNumberOfParams")
    end
  
    it "should send request with email, phone, telefono and account" do
      params = {:person => { :email => "ivan@bakedweb.net", :nombre => "3057737020", :telefono => "3057737020", :account => "bakedweb"} }
      lambda { Bakedweb::Delegator.envia(params) }.should_not raise_exception("WrongNumberOfParams")
    end
  end
  
  describe "Sending data with RestClient" do 
    before(:all) do 
      params = {:person => { :email => "ivan@bakedweb.net", :nombre => "ivanho", :telefono => "3057737020", :account => "bakedweb"} }
      @response = Bakedweb::Delegator.envia(params)
    end
    
    it "should use restclient" do
      @response.class.should == String
    end
    
    it "should return 201 for response" do
      @response.code.should == 201
    end
  end
end