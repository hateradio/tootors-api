require 'json'

class Tootor
  attr_accessor :id, :email, :username, :password, :name, :phone,
    :street, :city, :state, :zip, :focus, :description, :created_at,
    :updated_at, :visited_at, :seo_name, :picture, :video

  attr_reader :price, :is_tootor

  def initialize
    @id = 0
    @email = ''
    @is_tootor = false
    @username = ''
    @password = ''
    @name = ''
    @price = 0.0
    @street = ''
    @city = ''
    @state = ''
    @zip = ''
    @focus = ''
    @description = ''
    @seo_name = ''
    @video = ''
    @picture = ''
    @created_at = nil
    @updated_at = nil
    @visited_at = nil
  end

  # fill the Tootor with data from URL parameters
  def fill(params)
    p params

    (instance_variables - [:@id]).each { |prop|
      at_property = "#{prop}"
      ary_property = prop.to_s.delete('@')

      # p prop, prop.to_s.delete('@'), at_property, params[ary_property]

      if (params[ary_property])
        data = clean_str(params[ary_property])
        if (ary_property == 'price')
          instance_variable_set(at_property, data.to_f)
        else
          instance_variable_set(at_property, data)
        end
      end
    }

    self
  end

  def is_tootor=(bool)
    b = false

    if (String === bool)
      b = ['t', 'true'].include?(bool)
    elsif (TrueClass === bool || FalseClass === bool)
      b = bool
    end

    @is_tootor = b
  end

  def price=(p)
    if (p.nil?)
      @price = 0
    else
      @price = p.to_f
    end
  end

  def errors
    errors = string_props.map { |prop|
      property = "@#{prop}"
      c = clean_str(instance_variable_get(property))
      # p property, c, prop
      if (c == "")
        prop
      end
    }

    errors.push('price') if (@price.to_f < 0)

    errors.select { |e| !e.nil? }
  end

  def string_props
    ['email', 'username', 'password', 'name', 'phone', 'street', 'city',
      'state', 'zip', 'focus',
      'description', 'seo_name', 'picture', 'video']
  end

  def clean_str(attr)
    if attr.nil?
      ''
    else
      attr.squeeze(' ').strip.gsub(/[<]/, '&gt;')
    end
  end

  # converts Tootor to an array - properties ordered for inserting into DB
  def to_a
    [@id, @is_tootor, @username, @seo_name, @email, @password,
      @name, @phone, @price, @street, @city, @state,
      @zip, @focus, @description, @picture, @video,
      @created_at, @updated_at, @visited_at]
  end

  def to_hash
    data = {}

    instance_variables.each { |prop|
      data[prop.to_s.delete('@')] = instance_variable_get(prop)
    }

    data
  end

  def to_json
    JSON.generate(to_hash)
  end

  def to_json_with_errors
    JSON.generate({errors: errors, tootor: to_hash})
  end
end
