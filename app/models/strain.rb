class Strain < ApplicationRecord
	enum strain_type: {
    :indica 		=> 0,
    :sativa 		=> 1,
    :hybrid 		=> 2,
    :ruderalis 	=> 3,
    :unknow 		=> 10
  }

  def self.search(params)
    events = Strain.all

    if params[:search].present?
      events = events.where('name iLIKE ?', "%#{params[:search]}%")
    end

    if params[:strain_type].present?
      events = events.where(strain_type: params[:strain_type])
    end

    if params[:location].present?
      events = events.where('location iLIKE ?', "%#{params[:location]}%")
    end

    if params[:breeder].present?
      events = events.where(breeder: params[:breeder])
    end

    if params[:effect].present?
      events = events.where('effects @> ARRAY[?]', [params[:effect]])
    end

    if params[:ailment].present?
      events = events.where('ailments @> ARRAY[?]', [params[:ailment]])
    end

    if params[:flavor].present?
      events = events.where('flavors @> ARRAY[?]', [params[:flavor]])
    end

    return events
  end
end
