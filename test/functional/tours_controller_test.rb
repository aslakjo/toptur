require 'test_helper'

class ToursControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tours)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_tour
    assert_difference('Tour.count') do
      post :create, :tour => { }
    end

    assert_redirected_to tour_path(assigns(:tour))
  end

  def test_should_show_tour
    get :show, :id => tours(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tours(:one).id
    assert_response :success
  end

  def test_should_update_tour
    put :update, :id => tours(:one).id, :tour => { }
    assert_redirected_to tour_path(assigns(:tour))
  end

  def test_should_destroy_tour
    assert_difference('Tour.count', -1) do
      delete :destroy, :id => tours(:one).id
    end

    assert_redirected_to tours_path
  end
end
