module StatusView

  def show_status
    keys = %w(left right up down q)
    @statusline = para "Available keys: #{keys.to_sentence}"
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
