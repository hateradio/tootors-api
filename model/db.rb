require 'pg'
#require './tootor.rb'

# When running this code on the server, make sure to export
# https://deveiate.org/code/pg/PG/Connection.html
# export DB_CONNECTION='dbname=my-db-name user=my-user-name password=my-pass'
class TootorsDb
  def self.connect
    if (ENV['DB_CONNECTION'])
      PG.connect(ENV['DB_CONNECTION'])
    else
      PG.connect(dbname: 'android')
    end
  end

  # fixes is_tootor when PG returns 't' or 'f' instead of booleans
  def self.fixbooleans(results)
    results.to_a.map { |x|
      x['is_tootor'] = x['is_tootor'] == 't'
      x
     }
  end

  def self.all
    conn = self.connect
    list = conn.exec('select * from tootors')
    conn.close
    self.fixbooleans(list)
  end

  def self.search(clause, text)
    conn = self.connect

    property = conn.escape_string(clause)

    if (property == "is_tootor")
      res = conn.exec_params("select * from tootors where is_tootor = $1::boolean", [text])
    else
      res = conn.exec_params("select * from tootors where #{property} ilike $1::text",
        ["%#{text}%"]) #ilike is case insensitive
    end

    conn.close

    self.fixbooleans(res)
  end

  def self.find(id)
    conn = self.connect

    res = conn.exec_params('select * from tootors where id = $1::int', [id])

    conn.close

    if (res.num_tuples)
      t = Tootor.new

      res.first.each { |key, val| t.public_method("#{key}=").call(val) }

      t
    else
      nil
    end
  end

  def self.find_with_password(id, password)
    conn = self.connect

    res = conn.exec_params('select * from tootors where id = $1::int and password = $2::text',
      [id, password])

    conn.close

    if (res.num_tuples > 0)
      t = Tootor.new

      res.first.each { |key, val| t.public_method("#{key}=").call(val) }

      t
    else
      nil
    end
  end

  def self.insert(tootor)
    conn = self.connect

    insert = conn.exec_params('insert into tootors values (nextval(\'tootors_id_seq\'),
      $1::boolean, $2::varchar, $3::varchar, $4::varchar, $5::text,
      $6::varchar, $7::varchar, $8::varchar, $9::varchar, $10::varchar,
      $11::varchar, $12::text, $13::text, $14::text, $15::text
      current_timestamp, current_timestamp, current_timestamp)',
      tootor.to_a[1, 15])

    tootor = nil

    if (insert.cmd_tuples == 1)
      id = conn.exec('SELECT currval(\'tootors_id_seq\')')
      tootor = self.find(id.first['currval'].to_i)
    end

    conn.close

    tootor
  end

  def self.update(tootor)
    conn = self.connect

    if (tootor.id > 0)

      # p tootor.to_a[0, 13]
      update = conn.exec_params('update tootors set
        is_tootor = $2::boolean, username = $3::varchar, seo_name = $4::varchar,
        email = $5::varchar, password = $6::text,
        name = $7::varchar, phone = $8::varchar, street = $9::varchar,
        city = $10::varchar, state = $11::varchar,
        zip = $12::varchar, focus = $13::text, description = $14::text,
        image = $15::text, video = $16::text
        updated_at = current_timestamp
        where id = $1::int',
        tootor.to_a[0, 16])
    end

    conn.close

    tootor
  end
end
