# frozen_string_literal: true

user_attrs = [
  {
    username: 'kato',
    password: 'password',
    first_name: '加藤',
    last_name: '洋一',
    email: 'kato@example.com',
    phone: '09011111111'
  }
]
User.create(user_attrs)

pet_attrs = [
  { name: 'ペルシャ猫', tag: '猫' },
  { name: '柴犬', tag: '犬' }
]
Pet.create(pet_attrs)
