module SpreeShowcase
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../assets", __FILE__)

      def messages
        @messages||= []
      end

      def copy_message
        status = status.to_s.capitalize
        "Copy #{@source} into #{@dest}..."
      end

      def add_overrides
        @source = "overrides/showcase/add_showcase_to_home_layout.rb"
        @dest = "app/overrides/showcase/add_showcase_to_home_layout.rb"
        if copy_file(@source, @dest)
          messages << copy_message
        else
          messages << copy_message
        end
      end

      def add_javascripts
        if !File.exists?('app/assets/javascripts/spree/frontend/all.js')
          Dir.mkdir('app/assets/javascripts/spree') if !File.exists?('app/assets/javascripts/spree')
          Dir.mkdir('app/assets/javascripts/spree/frontend') if !File.exists?('app/assets/javascripts/spree/frontend')
          File.open('app/assets/javascripts/spree/frontend/all.js', "w") do |f|
            f.write('//showcase stuff')
          end

        end

        append_file 'app/assets/javascripts/spree/frontend/all.js', "//= require jquery.flexslider\n"
        @source  = "vendor/javascripts/jquery.flexslider.js"
        @dest    = "vendor/assets/javascripts/spree/frontend/jquery.flexslider.js"
        if copy_file(@source, @dest)
          messages << copy_message
        else
          messages << copy_message
        end

        append_file 'app/assets/javascripts/spree/frontend/all.js', "//= require ./flex_config.js.coffee\n"
        @source  = "vendor/javascripts/flex_config.js.coffee"
        @dest    = "app/assets/javascripts/spree/frontend/flex_config.js.coffee"

        if copy_file(@source, @dest)
          messages << copy_message
        else
          messages << copy_message
        end
      end

      def add_stylesheets
        if !File.exists?('app/assets/stylesheets/spree/frontend/all.css') && !File.exists?('app/assets/stylesheets/spree/frontend/all.css.scss')
          Dir.mkdir('app/assets/stylesheets/spree') if !File.exists?('app/assets/stylesheets/spree')
          Dir.mkdir('app/assets/stylesheets/spree/frontend') if !File.exists?('app/assets/stylesheets/spree/frontend')
          File.open('app/assets/stylesheets/spree/frontend/all.css', "w") do |f|
            f.write('/*spree_showcase*/')
          end
        end

        if File.exists?('app/assets/stylesheets/spree/frontend/all.css')
          inject_into_file 'app/assets/stylesheets/spree/frontend/all.css', " *= require frontend/spree_showcase\n", :before => /\*\//, :verbose => true
        elsif File.exists?('app/assets/stylesheets/spree/frontend/all.css.scss')
          inject_into_file 'app/assets/stylesheets/spree/frontend/all.css.scss', "@import 'showcase';\n", :before => /\*\//, :verbose => true
        end

        @source = "stylesheets/store/showcase.css.scss"
        @dest = "app/assets/stylesheets/spree/frontend/showcase.css.scss"
        if copy_file(@source, @dest)
          messages << self.copy_message
        else
          messages << self.copy_message
        end

        @source = "vendor/stylesheets/jquery.flexslider.css"
        @dest = "vendor/assets/stylesheets/spree/frontend/jquery.flexslider.css"
        if copy_file(@source, @dest)
          messages << copy_message
        else
          messages << copy_message
        end
        puts "showcase.css styles are required by the extension and can be changed in anyway to fit your own _showcase.html.erb\n"
      end

      def add_partials
        puts %q{This partial is the template structure for displaying the slideshow and also includes the settings for the JavaScript plugin.}

        @source = "partials/_showcase.html.erb"
        @dest = "app/views/spree/slides/_showcase.html.erb"
        if copy_file(@source, @dest)
          messages << copy_message
        else
          messages << copy_message
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_showcase'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skiping rake db:migrate, don\'t forget to run it!'
         end
      end

      def complete
        puts "\n-------- Files copied --------\n"
        puts messages.join("\n")
        puts "\n---------------------------------\n"
        puts "\nEverything is done! To summarize, _showcase.html.erb => HTML template, showcase.css.scss & showcase.js.erb => assets. Edit these 3 files to fit run the slideshow."
        puts "\nPlease run rake assets:clean (IMPORTANT) to clear any precompiled assets from fresh install of Spree."
      end
    end
  end
end
