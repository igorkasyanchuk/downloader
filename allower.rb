class Allower

  class << self

    def good?(url = '')
      url = url.strip
      no_blank(url) &&
      only_list_if_ua_allowed(url) &&
      is_not_root(url) &&
      no_search(url) &&
      no_afisha_pages(url) &&
      no_contact_page(url) &&
      no_redirect_page(url) &&
      no_comments_page(url) &&
      no_filter_by_pages(url) &&
      no_users_pages(url) &&
      no_metas(url) &&
      no_map_pages(url) &&
      no_seo_pages(url) &&
      no_price_pages(url) &&
      is_business_page(url)
    end

    private

      def no_blank(url)
        url != ''
      end

      def only_list_if_ua_allowed(url)
        !!(url =~ /^\/|^http:\/\/list.if.ua/)
      end

      def is_not_root(url)
        !!!(url =~ /^\/$/)
      end

      def no_search(url)
        !!!(url =~ /\?search=|\&search=/)
      end

      def no_afisha_pages(url)
        !!!(url =~ /^\/afisha\/?|\/new_event/)
      end

      def no_contact_page(url)
        !!!(url =~ /\/contact/)
      end

      def no_redirect_page(url)
        !!!(url =~ /\/redirect/)
      end

      def no_comments_page(url)
        !!!(url =~ /^\/comments|http:\/\/list.if.ua\/comments/)
      end

      def no_filter_by_pages(url)
        !is_filter_by_page(url)
      end

      def is_filter_by_page(url)
        !!(url =~ /\/filter_by\//)
      end

      def is_business_page(url)
        !!(url =~ /\/businesses\/\d+[a-z\-0-9]*$/)
      end

      def is_business_map_page(url)
        !!(url =~ /\/businesses\/\d+[a-z\-0-9]*\/map$/)
      end

      def no_users_pages(url)
        !!!(url =~ /(http:\/\/|^)(\/login|\/register)/)
      end

      def no_metas(url)
        !!!(url =~ /http:\/\/list.if.ua\/metas|^\/metas/)
      end

      def no_map_pages(url)
        !!!(url =~ /http:\/\/list.if.ua\/map\/index|^\/map\/index/)
      end

      def no_seo_pages(url)
        !!!(url =~ /(http:\/\/list.if.ua)?\/seo_site_map/)
      end

      def no_price_pages(url)
        !!!(url =~ /(http:\/\/list.if.ua)?\/price/)
      end

  end

end
