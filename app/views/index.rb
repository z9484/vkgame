module IndexView

  def index
    title "VK game"
    e, pw = '', ''
    stack do
      para "Email:"
      e = edit_line
      para "Password:"
      pw = edit_line :secret => true
      flow do
        b = button "Let the Adventure Begin", :width => 300 do
          para "Downloading... please be patient"
          @@email = Utils.escape('e@e.com' || e.text)
          @@password = Utils.escape('test' || pw.text)
          params = "id=#{GAME_ID}&email=#{@@email}&password=#{@@password}"
          # download "#{VK_SERVER_URL}/pages/download?#{params}", :save => DBPATH do |r|
          #   if (200..300).include?(r.response.headers['Status'].to_i)
          # Character.delete_all
              visit '/game'
          #   else
          #     alert File.read(DBPATH)
          #     exit
          #   end
          # end
        end
      end
    end
  end

end
