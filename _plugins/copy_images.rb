module Jekyll
    class PostImageFile < StaticFile
        attr_writer :dest_dir
        def destination(dest)
            File.join(dest, @dest_dir, @name)
        end
    end

    class PostImagesGenerator < Generator
        def generate(site)
            @site = site
            site.posts.each do |post|
                post_dir = File.dirname(post.path)
                next if post_dir == '_posts'
                Dir.foreach(post_dir) do |entry|
                    if entry != '.' && entry != '..' && /[^\s]+\.(jpg|png|gif|bmp|svg)/i.match(entry)
                        image_file = PostImageFile.new(site, site.source, post_dir, entry)
                        image_file.dest_dir = post.url
                        site.static_files << image_file
                    end
                end
            end
        end
    end
end
