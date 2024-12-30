class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image # Adds attachment for the pet's image

  # List of 81 Turkish cities
  CITIES = [
    "Adana", "Ad\u0131yaman", "Afyonkarahisar", "A\u011Fr\u0131", "Amasya", "Ankara", "Antalya", "Artvin", "Ayd\u0131n", "Bal\u0131kesir",
    "Bilecik", "Bing\u00F6l", "Bitlis", "Bolu", "Burdur", "Bursa", "\u00C7anakkale", "\u00C7ank\u0131r\u0131", "\u00C7orum", "Denizli",
    "Diyarbak\u0131r", "D\u00FCzce", "Edirne", "Elaz\u0131\u011F", "Erzincan", "Erzurum", "Eski\u015Fehir", "Gaziantep", "Giresun",
    "G\u00FCm\u00FC\u015Fhane", "Hakk\u00E2ri", "Hatay", "Isparta", "\u0130stanbul", "\u0130zmir", "Kastamonu", "Kayseri", "K\u0131rklareli", "K\u0131r\u015Fehir",
    "Kocaeli", "Konya", "K\u00FCtahya", "Malatya", "Manisa", "Kahramanmara\u015F", "Mardin", "Mu\u011Fla", "Mu\u015F", "Nev\u015Fehir",
    "Ni\u011Fde", "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirda\u011F", "Tokat",
    "Trabzon", "Tunceli", "\u015Eanl\u0131urfa", "U\u015Fak", "Van", "Yalova", "Yozgat", "Zonguldak", "Aksaray", "Bayburt",
    "Karaman", "K\u0131r\u0131kkale", "Batman", "\u015E\u0131rnak", "Bart\u0131n", "Ardahan", "I\u011Fd\u0131r", "Kilis", "Osmaniye", "D\u00FCzce"
  ]

  AGES = [ "0-3 months", "3-6 months", "6-12 months", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12+" ]
  validates :age, presence: true, inclusion: { in: AGES, message: "%{value} is not a valid age" }
  validates :name, presence: true
  validates :location, presence: true, inclusion: { in: CITIES, message: "%{value} is not a valid city in Turkey" }
  validates :pet_type, presence: true, inclusion: { in: [ "Cat", "Dog", "Other" ] }
  validates :description, presence: true, length: { maximum: 500 }
  validates :breed, presence: true, if: -> { [ "cat", "dog" ].include?(pet_type) }
end
