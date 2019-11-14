# frozen_string_literal: true

# Because we're assuming this application will only ever have test data
User.destroy_all
Conversation.destroy_all
UserConversation.destroy_all

devola = User.create(username: 'devola', password: 'popola')
popola = User.create(username: 'popola', password: 'devola')
anemone = User.create(username: 'anemone', password: 'a2')
nier = User.create(username: 'nier', password: 'yonah')

Conversation.build([devola, popola])
Conversation.build([devola, anemone])
Conversation.build([popola, nier])
