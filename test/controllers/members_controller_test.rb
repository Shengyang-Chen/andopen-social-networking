require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Member.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Member.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
    assert_equal assigns['member'].id, session['member_id']
  end
end
