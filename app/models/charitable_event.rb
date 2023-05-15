# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos, accessors: %i[time viewer deadline]
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  enum city: {
    '全國' => 0,
    '臺北市' => 1,
    '新北市' => 2,
    '基隆市' => 3,
    '桃園市' => 4,
    '新竹市' => 5,
    '新竹縣' => 6,
    '苗栗縣' => 7,
    '臺中市' => 8,
    '彰化縣' => 9,
    '南投縣' => 10,
    '雲林縣' => 11,
    '嘉義市' => 12,
    '嘉義縣' => 13,
    '臺南市' => 14,
    '高雄市' => 15,
    '屏東縣' => 16,
    '宜蘭縣' => 17,
    '花蓮縣' => 18,
    '臺東縣' => 19,
    '澎湖縣' => 20,
    '金門縣' => 21,
    '連江縣' => 22,
    '離島地區' => 23
  }
end
