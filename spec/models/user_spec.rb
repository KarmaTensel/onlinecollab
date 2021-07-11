require 'rails_helper'

RSpec.describe User, type: :model do
  subject{
    User.new(email:"karmatensel@gmail.com", encrypted_password:"qwert123", admin:"false")
  }

  before { subject.save }

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "email should not be too long" do
    subject.email = 'a' * 30
    expect(subject).to_not be_valid
  end
  
  it "password should not be too short" do
    subject.encrypted_password = 'a'
    expect(subject).to_not be_valid
  end

  it "new user is not assigned admin" do
    expect(subject.admin).to be false
  end

end
