import consumer from "./consumer"

const appRoom = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // ⑨message_broadcast_jobによりブロードキャストされたデータが届く
  received(data) {
    // レンダリングされたことにより、dataの値は以下のようになっている
    // {message: "<div class='message'>↵  <p>a</p>↵</div>"}
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('beforeend', data['message']);
  },

  // ③続いてここが発火
  // room_channel.rbのspeakアクションを動かすためにspeak関数を定義する
  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});

// ②keypressはキーが入力された際に発火する
window.addEventListener("keypress", function(e) {
  // Enterキーが押された時に発火
  if (e.keyCode === 13) {
    // Enterキーが押された際にroom_channel.jsのspeakアクションを発火させている
    // そのため一旦ここで22行目に戻る
    appRoom.speak(e.target.value);

    // speakアクションの動作が終わった後に、以下の記述が発火する
    e.target.value = '';
    e.preventDefault();
  }
})