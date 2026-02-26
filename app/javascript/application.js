// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// Rails UJS ou Turbo doit être actif pour que method: :delete fonctionne depuis un lien <a>
import Rails from "@rails/ujs"
Rails.start()