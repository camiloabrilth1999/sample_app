require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout liks" do
  #   assert true
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:2 #Count:2 es porque existen 2 enlaces a home (ruta raiz) 1. Del logo y otro parte del menu
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
