class School < ApplicationRecord

  validates :nom, presence: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  before_save :check_lat_lng

  def self.filter(params)

    out = []
    if params[:status].blank?
      out = School.all
    else
      out = School.where(['status = ?', params[:status]])
    end

    return out.order(nom: :asc)

  end

  private
  def check_lat_lng

    self.latitude = latitude.to_f
    self.longitude = longitude.to_f

  end

end
