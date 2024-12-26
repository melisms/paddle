class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image # Adds attachment for the pet's image

  # List of 81 Turkish cities
  CITIES = [
    'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
    'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli',
    'Diyarbakır', 'Düzce', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun',
    'Gümüşhane', 'Hakkâri', 'Hatay', 'Isparta', 'İstanbul', 'İzmir', 'Kastamonu', 'Kayseri', 'Kırklareli', 'Kırşehir',
    'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş', 'Nevşehir',
    'Niğde', 'Ordu', 'Osmaniye', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat',
    'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yalova', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt',
    'Karaman', 'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Kilis', 'Osmaniye', 'Düzce'
  ]

  AGES = ["0-3 months", "3-6 months", "6-12 months", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12+"]
  validates :age, presence: true, inclusion: { in: AGES, message: "%{value} is not a valid age" }
  validates :name, presence: true
  validates :location, presence: true, inclusion: { in: CITIES, message: "%{value} is not a valid city in Turkey" }
  validates :pet_type, presence: true, inclusion: { in: ['cat', 'dog', 'other'] }
  validates :breed, presence: true, if: -> { ['cat', 'dog'].include?(pet_type) }
end
