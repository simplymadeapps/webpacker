require 'rails/railtie'

require 'webpacker/helper'
require 'webpacker/digests'

class Webpacker::Engine < ::Rails::Engine
  initializer :webpacker do |app|
    ActiveSupport.on_load :action_view do
      include Webpacker::Helper
    end

    app.config.x.webpacker[:packs_dist_dir] ||= 'packs'
    app.config.x.webpacker[:packs_dist_path] ||= \
      "/#{app.config.x.webpacker[:packs_dist_dir]}"

    if app.config.x.webpacker[:digesting]
      app.config.x.webpacker[:digests_path] ||= \
        Rails.root.join('public',
                        app.config.x.webpacker[:packs_dist_dir],
                        'digests.json')

      Webpacker::Digests.load \
        app.config.x.webpacker[:digests_path]
    end
  end
end
