require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'spec'
require 'rubygems'
require 'fakeweb'
require 'delegator'

FakeWeb.register_uri(:get, "admin.bolsitosdecolores.com/people", :body => "success")


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
    it "should use restclient" do
      params = {:person => { :email => "ivan@bakedweb.net", :nombre => "3057737020", :telefono => "3057737020", :account => "bakedweb"} }
      Bakedweb::Delegator.envia(params).class.should == String
    end
  end
end