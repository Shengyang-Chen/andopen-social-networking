require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Member.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['member_id']
  end
  
  def test_create_valid
    Member.stubs(:authenticate).returns(Member.first)
    post :create
    assert_redirected_to root_url
    assert_equal Member.first.id, session['member_id']
  end
end
