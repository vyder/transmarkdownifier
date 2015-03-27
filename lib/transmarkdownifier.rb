$LOAD_PATH.unshift(__dir__)

# Load external dependencies
begin
    # To listen to file changes
    require 'listen'

    # Github Markup API
    require 'github/markup'

    # Templating
    require 'erb'

    # Pretty output
    require 'colorize'

rescue LoadError => e
  gem_name = e.path
  puts "Oops. Looks like you're missing the '#{gem_name}' gem."
  puts "Try running 'gem install #{gem_name}' to resolve this."
  exit(1)
end
%x(which chrome-cli)
if $?.exitstatus != 0
    puts "Oops. Looks like you don't have the 'chrome-cli' installed.".red
    puts "Try running 'brew install chrome-cli to resolve this.".red
    exit(1)
end

require 'transmarkdownifier/renderer'

module Transmarkdownifier
    def self.Start filename_arg
        file = File.new(filename_arg)

        # Orientation
        filename = File.basename(file)
        docname = File.basename(file, ".*")
        path = File.absolute_path(File.dirname(file))

        # Generate HTML for the Markdown file
        raw_html = Renderer.render(file)

        # Write the HTML out to a file
        html_filename = "#{path}/#{docname}.html"
        File.open(html_filename, 'w') {|f| f.write(raw_html) }

        # Open the HTML file in a new tab, in a new window
        # and figure out the tab's ID from the CLI output
        tab_id = %x( chrome-cli open "file://#{File.expand_path(html_filename)}" ).match(/^Id: (\d+)\n/)[1]

        # Create a Listener to watch for changes
        # to our Markdown file
        listener = Listen.to(path, only: /^#{filename}$/) do |modified, added, removed|
            # Regenerate HTML
            raw_html = Renderer.render(file)

            # Write to file
            File.open(html_filename, 'w') {|f| f.write(raw_html) }

            # Reload the Chrome tab
            %x( chrome-cli reload -t #{tab_id} )
        end

        # Start watching for Markdown file changes
        listener.start

        # Some helpful instructions
        puts "Climbing into the chamber...".green
        puts "[Ctrl+C to quit]".green

        # Sleep till interrupted
        begin
          sleep
        # Gotta catch 'em all
        rescue SystemExit, Interrupt, StandardError, Exception => e
          puts ""
          puts "Transmarkdownification complete!".green
          exit(0)
        end
    end
end