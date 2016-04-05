class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 250}
  validates :surname, presence: true, length: {maximum: 250}
  validates :gender, presence: true
  validates :email, presence: true

  has_attached_file :photo,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo,
                                    content_type: ['image/jpeg', 'image/gif', 'image/png']


  def full_name
    "#{surname} #{name}"
  end

end
