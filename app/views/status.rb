module MiscView

  def index
    @@email, @@password = '', ''
    @@email, @@password = File.read(CREDENTIALS_PATH).squish.split if File.exists?(CREDENTIALS_PATH)
    title "VK game"
    e, pw = '', ''
    stack do
      para "Email:"
      e = edit_line :text => @@email
      para "Password:"
      pw = edit_line :secret => true, :text => @@password
      flow do
        b = button "Let the Adventure Begin", :width => 300 do
          para "Downloading... please be patient"
          @@email, @@password = Utils.escape(e.text), Utils.escape(pw.text)
          File.open(CREDENTIALS_PATH, 'w') {|f| f << "#{@@email} #{@@password}"} unless File.exists?(CREDENTIALS_PATH)
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
        e.text.blank? ? e.focus : b.focus
      end
    end
  end

  def quit
    update_status("Saving game, please wait")
    exit
  end

  def show_status
    @statusline = para "Find the winning hut. Arrow keys to move."
    # button "Quit" do
    #   para "saving..."
    # params = "id=#{GAME_ID}&email=#{@@email}&password=#{@@password}"
    # c = Curl::Easy.new("#{VK_SERVER_URL}/pages/upload?#{params}")
    # c.multipart_form_post = true
    # c.http_post(Curl::PostField.file('game[data]', DBPATH))
    # if (200..300).include?(c.response_code)
    #   File.delete(DBPATH)
    # exit
    # else
    #   para "Error"
    # end
    # end
  end

  def update_status(message = '')
    @statusline.text = message
  end

end
