require 'spec_helper'

describe 'Allower' do

  it 'should check that page is not root' do
    Allower.send(:is_not_root, 'http://google.com').should be_true
    Allower.send(:is_not_root, '/').should be_false
  end

  it 'should allow only list.if.ua links' do
    Allower.send(:only_list_if_ua_allowed, 'http://list.if.ua').should be_true
    Allower.send(:only_list_if_ua_allowed, 'http://google.com?site=list.if.ua').should be_false
    Allower.send(:only_list_if_ua_allowed, '/').should be_true
  end

  it 'should not allow search pages' do
    Allower.send(:no_search, 'http://google.com?search=hello').should be_false
    Allower.send(:no_search, 'http://google.com?name=igor&search=hello').should be_false
    Allower.send(:no_search, 'http://google.com?name=igor').should be_true
    Allower.send(:no_search, 'http://google.com?name=search').should be_true
  end

  it 'should ignore afisha pages' do
    Allower.send(:no_afisha_pages, '/afisha').should be_false
    Allower.send(:no_afisha_pages, '/afisha/1').should be_false
    Allower.send(:no_afisha_pages, '/afisha/events').should be_false
    Allower.send(:no_afisha_pages, '/business/afisha/events').should be_true
  end

  it 'should ignore contact page' do
    Allower.send(:no_contact_page, '/contact').should be_false
    Allower.send(:no_contact_page, '/home').should be_true
  end

  it 'should ignore redirect page' do
    Allower.send(:no_redirect_page, '/redirect_from/1').should be_false
    Allower.send(:no_redirect_page, '/redirect').should be_false
    Allower.send(:no_redirect_page, '/home').should be_true
    Allower.send(:no_redirect_page, '/home?redirect=true').should be_true
  end

  it 'should ignore comments page' do
    Allower.send(:no_comments_page, '/comments').should be_false
    Allower.send(:no_comments_page, 'http://list.if.ua/comments').should be_false
    Allower.send(:no_comments_page, '/comments/111').should be_false
    Allower.send(:no_comments_page, '/business/1111/comments/111').should be_true
  end

  it 'should ignore filter by pages' do
    Allower.send(:no_filter_by_pages, '/filter_by/1/1/1').should be_false
    Allower.send(:no_filter_by_pages, 'http://list.if.ua/filter_by/0/0/1').should be_false
    Allower.send(:no_filter_by_pages, '/home/1/1/1').should be_true
  end

  it 'should ignore users pages' do
    Allower.send(:no_users_pages, '/register').should be_false
    Allower.send(:no_users_pages, '/login').should be_false
    Allower.send(:no_users_pages, '/users/login').should be_true
  end

  it 'should ignore metas' do
    Allower.send(:no_metas, 'http://list.if.ua/metas').should be_false
    Allower.send(:no_metas, '/metas').should be_false
    Allower.send(:no_metas, '/users/metas').should be_true
  end

  it 'should check if business page' do
    Allower.send(:is_business_page, '/businesses/13425-vulik-ivano-frankivsk').should be_true
    Allower.send(:is_business_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk').should be_true
    Allower.send(:is_business_page, 'http://list.if.ua/comments/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_page, '/comments/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/photos').should be_false
    Allower.send(:is_business_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/photos#open-0').should be_false
    Allower.send(:is_business_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/map').should be_false
  end

  it 'should check if business map page' do
    Allower.send(:is_business_map_page, '/businesses/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_map_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_map_page, 'http://list.if.ua/comments/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_map_page, '/comments/13425-vulik-ivano-frankivsk').should be_false
    Allower.send(:is_business_map_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/photos').should be_false
    Allower.send(:is_business_map_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/photos#open-0').should be_false
    Allower.send(:is_business_map_page, 'http://list.if.ua/businesses/13425-vulik-ivano-frankivsk/map').should be_true
  end

  it 'should check if map page' do
    Allower.send(:no_map_pages, '/map/index').should be_false
    Allower.send(:no_map_pages, 'http://list.if.ua/map/index').should be_false
    Allower.send(:no_map_pages, '/page/zzz/index').should be_true
  end

  it 'should check if seo page' do
    Allower.send(:no_seo_pages, 'http://list.if.ua/seo_site_map').should be_false
    Allower.send(:no_seo_pages, '/seo_site_map').should be_false
    Allower.send(:no_seo_pages, '/seo_page').should be_true
  end

  it 'should check if price page' do
    Allower.send(:no_price_pages, 'http://list.if.ua/price').should be_false
    Allower.send(:no_price_pages, '/price').should be_false
    Allower.send(:no_price_pages, '/pricing').should be_true
  end
end
