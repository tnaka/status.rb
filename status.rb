Session.pre_send_message_timeline_status do |sender, e|

  #変数とか。
  client_source = e.status.source.sub(/<a.*\">/,"").sub(/<\/a>/,"")
  client_source_disp = " (via #{client_source})"
  user_protected = ""
  location = e.status.user.location
  
  #時刻情報
  #e.status.created_at.to_sは"2010/06/29 0:00:00"形式 strftimeで扱えなかった
  created_time = e.status.created_at.to_s.split(" ")[1]
  
  #location情報の整形。
  if location != ""
    location = " (from #{location})"
  end
  
  #Protectedユーザーの区別とか整形とか。
  if e.status.user.protected  == TRUE
    user_protected = "¶ "
  end
  
  #なるほど四時じゃねーの拒否。使いたかったらコメント外す。
#  if client_source == "なるほど四時じゃねーの"
#    e.cancel = true
#  end
  
  #変数代入して終わり。
  e.text  =  "#{created_time} #{user_protected}#{e.text}\x0314#{location}#{client_source_disp}"

end