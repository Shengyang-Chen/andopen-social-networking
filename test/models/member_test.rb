require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def new_member(attributes = {})
    attributes[:first_name] ||= 'John'
    attributes[:last_name] ||= 'Doe'
    attributes[:url] ||= 'https://www.microsoft.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    member = Member.new(attributes)
    member.valid? # run validations
    member
  end
  
  def setup
    Member.delete_all
  end
  
  def test_valid
    assert new_member.valid?
  end
  
  def test_require_username
    assert new_member(:username => '').errors.on(:username)
  end
  
  def test_require_password
    assert new_member(:password => '').errors.on(:password)
  end
  
  def test_validate_uniqueness_of_username
    new_member(:username => 'uniquename').save!
    assert new_member(:username => 'uniquename').errors.on(:username)
  end
  
  def test_require_matching_password_confirmation
    assert new_member(:password_confirmation => 'nonmatching').errors.on(:password)
  end
  
  def test_generate_password_hash_and_salt_on_create
    member = new_member
    member.save!
    assert member.password_hash
    assert member.password_salt
  end
  
  def test_authenticate
    Member.delete_all
    member = new_member(:first_name => 'A', :last_name => 'B', 'url' => 'https://www.ruby-org.com', :password => 'secret')
    member.save!
    assert_equal member, Member.authenticate('A', 'B', 'https://www.ruby-org.com' 'secret')
  end
  
  def test_authenticate_bad_username
    assert_nil Member.authenticate('non', 'existing', 'https://example.com', 'secret')
  end
  
  def test_authenticate_bad_password
    Member.delete_all
    new_member(:first_name => 'A', :last_name => 'B', 'url' => 'https://www.ruby-org.com', :password => 'secret').save!
    assert_nil Member.authenticate('non', 'existing', 'https://example.com', 's3cr3t')
  end
end
