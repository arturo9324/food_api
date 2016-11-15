class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products, dependent: :destroy
  has_one :company, -> { where( User.find(:id).admin false ) }, dependent: :destroy
  scope :admin, -> {order ("admin ASC")}

  def be_admin
  	User.find_by_id(self.id).update_attribute( :admin, true )
  end

  def email=(address)
    if new_record?
      write_attribute(:email, address)
    end
  end 

end
