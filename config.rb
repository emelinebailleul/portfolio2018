# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

## This enable a lot of things
# Autoprefixer
activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
# Pretty URLs
activate :directory_indexes
# Localization
activate :i18n, :mount_at_root => :fr
# Using asset helpers
activate :asset_hash
# Using sprockets
activate :sprockets
# Loading images asynchronously
activate :async_image
# Middleman i18n can't convert page URL to another language. This is the solution.
activate :transpath
# For indicating an active link
activate :aria_current

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page 'sitemap.xml', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

## Helpers
# Requires all helpers
Dir["helpers/*.rb"].each {|file| require file }
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/
helpers ApplicationHelper

# Middleman fails to reload on helpers edit. This is the solution.
Dir['helpers/*'].each(&method(:load))


## Proxy - Dynamic pages
# Project-page generation
data.projects.each do |project|
  proxy "/projets/#{project.fr.slug}/index.html", "templates/project.html", :locals => { :project => project }, :locale => :fr, :ignore => true, :data => { :slug => project.fr.slug }
  proxy "en/projects/#{project.en.slug}/index.html", "templates/project.html", :locals => { :project => project }, :locale => :en, :ignore => true, :data => { :slug => project.en.slug }
end

## Build-specific configuration
# Under development
configure :development do
  config[:host] = "http://localhost:4567"
  activate :livereload
end

# Under deploy
configure :build do
  config[:host] = "https://portfolio-starter.netlify.com"

  activate :minify_html
  activate :minify_css
  activate :minify_javascript
  activate :imageoptim
  activate :gzip
  activate :critical

  # SEO
  activate :sitemap, :gzip => false, :hostname => config[:host]
  # Robots
  activate :robots,
    :rules => [
      {:user_agent => '*', :allow => %w(/)}
    ],
    :sitemap => config[:host] + "/sitemap.xml"
end
