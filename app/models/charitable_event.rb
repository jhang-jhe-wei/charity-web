# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos, accessors: %i[time viewer deadline]
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  SOURCE_WEBSITES = [
    { name: '伊甸社會福利基金會', url: 'https://volunteer.eden.org.tw/Hire', logo_url: 'https://volunteer.eden.org.tw/Imgs/logo.png' },
    { name: '善耕 365 公益媒合平台', url: 'https://harvest365.org/', logo_url: 'https://harvest365.org/wp-content/uploads/2020/02/logo_360-180x108.png' },
    { name: 'igiving 公益網', url: 'https://www.igiving.org.tw/contents/volunteer', logo_url: 'https://www.igiving.org.tw/www/img/logo.svg' },
    { name: '愛就夠公益網', url: 'https://www.ijogo.com.tw/w/iJogo/Work', logo_url: 'https://www.ijogo.com.tw/WebUPD/iJogo/Header/iJoGo_logo_220x80.png' },
    { name: '靖娟兒童安全文教基金會', url: 'https://www.safe.org.tw/volunteer/', logo_url: 'https://www.safe.org.tw/images/logo.svg' },
    { name: '臺北志工整合服務平臺', url: 'https://cv101.gov.taipei/Announcement/index.aspx', logo_url: 'https://cv101.gov.taipei/css/images/logo.png' },
    { name: '台灣公益資訊中心', url: 'https://www.npo.org.tw/volunteerlist.aspx?tid=143', logo_url: 'https://www.npo.org.tw/upload/%7B637520089479841839%7D_common_header_logo.png' }
  ].freeze

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
