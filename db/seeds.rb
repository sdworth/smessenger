# frozen_string_literal: true

# Because we're assuming this application will only ever have test data
Message.destroy_all
UserConversation.destroy_all
Conversation.destroy_all
User.destroy_all

devola = User.create(username: 'devola', password: 'popola')
popola = User.create(username: 'popola', password: 'devola')
anemone = User.create(username: 'anemone', password: 'a2')
nier = User.create(username: 'nier', password: 'yonah')

devola_popola = Conversation.build([devola.id, popola.id])
Conversation.build([devola.id, anemone.id])
Conversation.build([popola.id, nier.id])

Message.create(user: devola, conversation: devola_popola, body: "i found the part we're looking for")
Message.create(user: popola, conversation: devola_popola, body: "Oh good! Let's hurry back to camp.")
Message.create(user: devola, conversation: devola_popola, body: 'yeah. i think the kid will appreciate it')
