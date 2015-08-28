module Jekyll
    class MarkdownPreprocessor < Converter
        safe :false
        priority :high

        def matches(ext)
            ext =~ /^\.(md|markdown)$/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            # make correction for math
            content.gsub!(/\$\$/, "\n\$\$\n")
            content.gsub!(/\s\$\s/, "\s\$\$\s")

            # Now call the standard Markdown converter
            site = Jekyll::Site.new(@config)
            mkconverter = site.getConverterImpl(Jekyll::Converters::Markdown)
            mkconverter.convert(content)
        end
    end
end
