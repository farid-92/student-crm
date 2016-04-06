class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipient_depositories
  has_many :contact_lists, through: :recipient_depositories

  has_one :contact, dependent: :destroy
  accepts_nested_attributes_for :contact


  validates :name, presence: true, length: {maximum: 250}
  validates :surname, presence: true, length: {maximum: 250}
  validates :gender, presence: true



  has_attached_file :photo,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo,
                                    content_type: ['image/jpeg', 'image/gif', 'image/png']

  has_attached_file :passport_photo,
                    :path => ':rails_root/public/system/:attachment/:id/:style/:basename.:extension',
                    :url => '/system/:attachment/:id'

  validates_attachment_content_type :passport_photo, content_type: %w{
    application/zip
    image/jpeg
    image/gif
    image/png
  }


  def full_name
    "#{surname.capitalize} #{name.capitalize}"
  end

end
