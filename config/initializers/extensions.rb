module Utils

  # File actionpack/lib/action_controller/vendor/rack-1.0/rack/utils.rb, line 12
  def escape(s)
    s.to_s.gsub(/([^ a-zA-Z0-9_.-]+)/n) {
      '%'+$1.unpack('H2'*$1.size).join('%').upcase
    }.tr(' ', '+')
  end
  module_function :escape

end
