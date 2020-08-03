class RoomChannel < ApplicationCable::Channel
  # ①クライアントが接続した際に自動的に実行される
  # stream_fromメソッドを使用することで、room_chanel.js(クライアントサイド)とroom_channel.rb(サーバーサイド)間でデータ送受信が可能になる
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
  end

  # ④room_channel.jsによりspeakアクションが発火
  def speak(data)
    # このままでは送られてきたデータがDBに保存されないので、以下のような記述を追記する
    Message.create! content: data['message']
  end
end
