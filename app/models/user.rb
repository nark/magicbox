class User < ApplicationRecord
	acts_as_token_authenticatable
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :alert_users
  has_many :alerts, through: :alert_users

  has_many :observations
  has_many :notifications
  has_many :todos


  def todos_count
    todos.where(todo_status: :todo).count
  end


  def unread_notifications_count
  	notifications.where(read: false).count
  end

  def mark_notifications_as_read
    notifications.where(read: false).update_all(read: true)
  end
end
