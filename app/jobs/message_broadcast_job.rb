class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # ⑥messageモデルの記述により、MessageBroadcastJobのperformが遅延実行される
  def perform(message)
    # ⑧レンダリングされたビューが返ってくる
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  private

  # ⑦render_message(message)が呼び出される
  def render_message(message)
    # messageは「#<Message:0x00007ff10351fb70 id: 1, content: "test", created_at: Sat, 01 Aug 2020 12:38:23 UTC +00:00, updated_at: Sat, 01 Aug 2020 12:38:23 UTC +00:00>」になっている
    # ApplicationController.renderer.renderメソッドを使うと、コントローラ以外の場所でビューをレンダリングできる
    # 今回の場合は、<div class='message'><p>投稿したテキスト</p></div>が返ってくる
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
