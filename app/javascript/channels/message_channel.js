import consumer from "./consumer"

window.addEventListener('load', () => {
  const conversationIdTag = document.getElementById('conversationId');

  if(conversationIdTag){
    const conversationId = conversationIdTag.innerText;

    consumer.subscriptions.create({channel: "MessageChannel", id: conversationId}, {
      received(data) {
        if(!(data.user_id == document.getElementById('userId').innerText)) {
          const newMessage = document.createElement("li");
          const messageText = document.createTextNode(`${data.username}: ${data.body}`);

          newMessage.appendChild(messageText);

          document.getElementById('messages').appendChild(newMessage);
        }
      }
    });
  }
});
