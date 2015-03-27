module Transmarkdownifier

    # Converts markdown to HTML
    module Renderer

        def self.render markdown_filename, opts = {}
            filename = File.expand_path(markdown_filename)

            # Generate the HTML content
            content = GitHub::Markup.render(filename, File.read(filename))

            # Compile a list of CSS strings to inject
            # into the template
            stylesheets = []

            # This gross one-liner basically:
            # 1. Finds the styles directory relative to this file
            # 2. Compiles an array of absolute paths to stylesheet files
            stylesheet_files = Dir.glob(File.expand_path("./styles/*.css", File.dirname(__FILE__)))

            # Read all the stylesheets
            stylesheet_files.each do |stylesheet_filename|
                stylesheets << File.read(stylesheet_filename)
            end

            # Load up the required template
            template_name = opts[:template] || 'github'
            template_file = File.expand_path("./templates/#{template_name}.erb", File.dirname(__FILE__))
            unless File.exist? template_file
                raise "Could not find a template for '#{template_name}'."
            end
            template = ERB.new(File.read(template_file))

            # Inject content and stylesheets,
            # and return the compiled template
            template.result(binding)
        end
    end
end