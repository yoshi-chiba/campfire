class Message < ApplicationRecord
  # ⑤データベースの情報保存後、ここが発火する
  # { MessageBroadcastJobのperformを遅延実行 引数はself }
  # 言い換えれば、DBにデータが保存された後にmessage_broadcast_job.rbのperformアクションを実行すると言うことになる
  after_create_commit { MessageBroadcastJob.perform_later self }
end
