module FormatterHelper

  # in  : "John + Bob"
  # out : "<strong>John</strong> +<br><strong>Bob</strong>"
  def format_pair_names(names)
    parts = names.split(/\s*(\+)\s*/)
    
    if parts.length == 3
      a, b, c = parts
      "<strong>#{a}<strong>#{b}<br><strong>#{c}</strong>"
    else
      names
    end  
  end

  # in:  dev+alainravet_kishiamy@gmail.com
  # out: dev+<b>alainravet</b>_<b>kishiamy</b><br>@gmail.com
  def format_pair_email(email)
    parts = email.split(/([+_@])/)

    if parts.length == 7
      a, b, c, d, e, f, g = parts
      "#{a}#{b}<strong>#{c}</strong>#{d}<strong>#{e}</strong><br>#{f}#{g}" #
    else
      email
    end
  end
end

Cuba.plugin FormatterHelper