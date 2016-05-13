require 'json'

class Tootor
  attr_accessor :id, :is_tootor, :username, :password, :name, :street,
    :city, :state, :zip, :focus, :description, :created_at, :updated_at,
    :visited_at, :seo_name

  attr_reader :price

  def initialize
    @id = 0
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
    @created_at = nil
    @updated_at = nil
    @visited_at = nil
  end

  # fill the Tootor with data from URL parameters
  def fill(params)
    p params

    instance_variables.each { |prop|
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

  def price=(p)
    if (p.nil?)
      0
    else
      p.to_f
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
    ['username', 'password', 'name', 'street', 'city', 'state', 'zip', 'focus',
      'description', 'seo_name']
  end

  def clean_str(attr)
    if attr.nil?
      ''
    else
      attr.squeeze(' ').strip.gsub(/[<]/, '&gt;')
    end
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
