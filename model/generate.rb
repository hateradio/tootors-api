require 'pg'

# Generates 100 user entries
class Generator

  def template
    rows = (1..100).map { |i|
      n = name
      seo = name.downcase.gsub(' ', '-')
      u = username + i.to_s

      "(nextval('tootors_id_seq'), '#{bool}', '#{u}',
        '#{seo}', '#{u}@geemail.com', 'password#{i}', '#{n}', '#{phone}',
        '#{address}', 'Los Angeles', 'CA', '#{zip}',
        '#{focus}', 'I am a smart person!',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
    }.join(', ')

    sql = 'insert into tootors values ' + rows

    # conn.exec(sql)

    sql
  end

  def insert
    conn = PG.connect(dbname: 'android')
    res = conn.exec(template)
    conn.close
    res
  end

  private

  NAMES = ['Tessa Rochin', 'Seema Carbaugh', 'Kina Crosby', 'Lori Haliburton',
    'Lashunda Benavidez', 'Marsha Crean', 'Elbert Stroble',
    'Lorriane Schmeling', 'Corey Merced', 'Santiago Salamanca',
    'Mandie Banvelos', 'Keesha Setzer', 'Kraig Warden', 'Samantha Meuser',
    'Stefania Chaisson', 'Marcie Badura', 'Marquerite Thurmond',
    'Carolee Braverman', 'Dexter Dowless', 'Dodie Oliver',
    'Joaquina Fackler', 'Kori Santillanes', 'Marianna Koval',
    'Kathy Bejarano', 'Scarlett Warkentin', 'Hong Buckles',
    'Crysta Tedrick', 'Ethyl Morant', 'Drema Moors', 'Nigel Gall',
    'Ike Whitmore', 'Ariane Tavera', 'Pamala Orris', 'Sherri Otani',
    'Rene Polak', 'Lahoma Garza', 'Mozell Depew', 'Stephan Guthmiller',
    'Tobi Luton', 'Felix Cosey', 'Adeline Milani', 'Raquel Pareja',
    'Linnie Whitbeck', 'Johnson Cockrum', 'Hobert Fenimore', 'Kaley Mannix',
    'Cleopatra Schaub', 'Conrad Grau', 'Dinah Darner', 'Ophelia Duwe']

  USERNAMES = ['empanadaplanemo', 'toastermotions', 'therapyhappy', 'crackingmanners',
    'bitewolf', 'reflexsynonyms', 'monumentalpuddings', 'letsgreat',
    'indeliblepoison', 'imploretower', 'wretchdog', 'mountingthorne',
    'heardlists', 'oxygenrosacea', 'boozehypothesis', 'damagingpedlar',
    'blackfishmatter', 'tropicalgrab', 'uneveninvents', 'playerarchitect',
    'rattyescape', 'boyscoutsguessing', 'murreletobesity', 'apertbrazilian',
    'sawtfaded']

  FOCUS = %w[Math Reading Algebra Chemistry Science Geometry Computer\ Science]

  def bool
    [true, false].sample
  end

  def username
    USERNAMES.sample
  end

  def name
    NAMES.sample
  end

  def phone
    "(#{Random.rand(100...999)}) 555-#{Random.rand(1000...9999)}"
  end

  def address
    loc = %w[Ave Blvd St Dr]
    "#{Random.rand(100...99999)} Street #{loc.sample}"
  end

  def zip
    Random.rand(90001...90010)
  end

  def focus
    FOCUS[Random.rand(0..3), Random.rand(1..FOCUS.length - 1)].join(', ')
  end

end


# p Generator.new.insert
