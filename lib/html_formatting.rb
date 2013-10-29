module HTMLFormatting
  # Take any HTML and make it safe, preserving formatting where possible so that it looks OK
   # when you run if back through the format method (below).
   def self.cleanse(text)
     RichText.new(text).cleanse
   end

   # Recognize URLs in plain text and add links. You should probably run the output of this method
   # through something like simple_format
   def self.format(plain_text)

     # Internal links
     linked = plain_text.gsub(/\B(?:\"|&quot;)([^\"]+)(?:\"|&quot;):(\/[^\s]*[^.\?\,\:\;\s]{1})\b/i) do 
       caption = $1
       # Strictly, it's the path and the query string
       path = $2
       "<a href=\"http://#{base_hostname}#{path}\">#{caption}</a>"
     end 

     # (https?:\/\/)? allows either http or https only. The protocol is optional.
     # ((?:[\-a-z]*\.){1,}[a-z]{2,3}) matches the domain. It needs at least two words and the second (TLD)
     # needs to be 2 or 3 letters long.
     # (\/(?:[^\s]*[^.\s]{1})?)? matches the path and query string. It will drop a trailing punctuation because
     # that is unlikely to be part of the URL and more likely to be the end of a sentence (e.g.
     # Take a look at myartchannel.com.")
     linked.gsub!(/\b(@|https?:\/\/)?((?:[\-a-z0-9]+\.){1,}[a-z]{2,3})(\/(?:[^\s]*[^.\?\,\:\;\s]{1})?)?\b/i) do 
       # Strictly, the protocol doesn't include the :// but we're lumping it in here
       protocol = $1 || "http://"
       domain = $2
       # Strictly, it's the path and the query string
       path = $3
       parts = domain.split('.')
       # parts.last =~ /[A-Z]+/ checks to see if there is an uppercase letter in the final part of the
       # domain. If there is, and there is no defined protocol or path then it's probably just a badly
       # spaced sentence. 
       # !suffix.nil? checks to see whether the 2 or 3 letter tld is part of a larger word.
       if protocol == '@'
         "#{protocol}#{domain}#{path}"
       elsif $1.nil? && path.nil? && parts.size < 3 && (parts.last =~ /[A-Z]+/)
         "#{domain}"
       else
         caption = "#{domain}#{path}"
         if caption.size > 30
           caption = caption.slice(0..40) + "..."
         end
         "<a href=\"#{protocol}#{domain}#{path}\">#{caption}</a>"
       end
     end 

     # Emails
     linked.gsub!(/\b([a-z.+-_0-9]*)\@((?:[\-a-z0-9]+\.){1,}[a-z]{2,3})\b/i) do 
       email = "#{$1}@#{$2}"
       "<a href=\"mailto:#{email}\">#{email}</a>"
     end 

     return linked
   end

   def self.simple_format(text, html_options={}, options={})
     text = ''.html_safe if text.nil?
     start_tag = '<p>'
     text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
     text.gsub!(/\n\n+/, "</p>\n\n<p>")  # 2+ newline  -> paragraph
     text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
     text.insert 0, '<p>'
     text.html_safe.safe_concat("</p>")
   end


   class RichText < String

     def cleanse
       destroy_tag('script', 'style')
       strip_tag('p', 'div', 'pre', 'h[1-9]{1}', 'blockquote', 'xml') { "\n\n" }
       strip_tag('font', 'span', 'i', 'b', 'u', 'em', 'strong', 'table', 'tbody', 'tr', 'td')
       # Weird MS Office stuff
       strip_tag('o:p', '\?xml:namespace')

       # Treat images specially
       gsub! /<\s*img\s.*src=["']+([^'"]*)[^>]*>/ do 
         @log ||= []
         src = $1
         if src =~ /myartchannel.com/ || src =~ /^..\//
           # internal URL (or relative path)
           id = src.sub /^.*\/artworks\/(\d+)[^\d]*.*$/, '\1'
           @linked_images ||= []
           @linked_images << id
           ""
         else
           @linked_images ||= []
           @linked_images << src
           ""
         end
       end

       # Convert links into "caption (link)"
       gsub! /<\s*a\s.*href=["']+([^'"]*)[^>]*>(.*?)<\s*\/a\s*>/ do 
         if $2 == $1
           $2
         else
           "#{$2} (#{$1})"
         end
       end

       # <br> Only appends one new line
       gsub! /<\s*br(\s+[^>]*)*\/?\s*>/mi, "\n"

       # Look for <tag>...</tag>
       gsub!(/<\s*([^>]*)>.*?<\s*\/\1\s*>/mi) do 
         @log ||= []
         @log << "Lost tag <#{$1}>"
         ""
       end
       # Look for <tag/>
       gsub!(/<(.*)\/\s*>/mi) do 
         @log ||= []
         @log << "Lost tag <#{$1}>"
         ""
       end

       # Ignore line feed
       gsub! /\r/, ""
       # Ignore too many blank lines
       gsub! /\n{3,}/, "\n\n"

       gsub! /[\xF0\xA0]+/, '-' # hyphen
       gsub! /[\x80-\xFF]+/, '' # non-printable
       gsub! /&nbsp;/m, ' '
       gsub! /&amp;/m, '&'
       gsub! /&gt;/m, '>'
       gsub! /&lt;/m, '<'

       return self
     end

     def lossful?
       @log && @log.size > 0
     end

     def log
       @log
     end

     def linked_images
       @linked_images || []
     end

     # Completely remove tag and contents. E.g.
     # <script>this is removed</script>
     def destroy_tag(*tags)
       tags.each do |tag|
         gsub! Regexp.new("<\s*#{tag}[^>]*>.*?<\s*\/#{tag}\s*>", Regexp::IGNORECASE + Regexp:: MULTILINE), ''
       end
     end

     # Strip the tag and replace with the contents plus some text. E.g.
     # <p>Text</p> -> Text\n\n
     def strip_tag(*tags, &block)
       tags.each do |tag|
         gsub! Regexp.new("<\s*#{tag}(?:\s+[^>]*)*>(.*?)<\s*\/#{tag}\s*>", Regexp::IGNORECASE + Regexp:: MULTILINE) do
           if block
             "#{$1}#{yield}"
           else
             $1
           end
         end
         # check we don't have any malformed or nested instances left
         gsub! Regexp.new("<\s*#{tag}(?:\s+[^>]*)*>", Regexp::IGNORECASE + Regexp:: MULTILINE), ''
         gsub! Regexp.new("<\s*\/#{tag}\s*>", Regexp::IGNORECASE + Regexp:: MULTILINE), ''
       end
     end

     private :destroy_tag, :strip_tag

   end
end