module ApplicationHelper
  def mac_format(text, options = {})
    if options[:length]
      text = truncate_words(text, :length => options[:length], :omission => "HELLIP")
    end
    linked = HTMLFormatting.format(h(text))
    if !options[:compact]
      linked = simple_format(linked)
    end
    linked.blank? ? linked : linked.sub("HELLIP", "&hellip;").html_safe
  end
end
