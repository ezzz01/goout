# Sample localization file for Lithuanian. Add more files in this directory for other locales.
# See http://github.com/svenfuchs/rails-i18n/tree/master/rails%2Flocale for starting points.
{
:lt => {
  :mydate => "Data",
  :start_page => "Pradinis puslapis",
  :users => "Vartotojai",
  :community => "Bendruomenė",
  :help => "Pagalba",
  :about => "Apie projektą",
  :countries => "Šalys",
  :title => "Pavadinimas",
  :blog => "Tinklaraštis",
  :studies => "Studijos",
  :body => "Body?",
  :tags => "Žymės",
  :new_entry => "Sukurti naują",
  :new_university => "Sukurti naują universitetą ar organizaciją",
  :new_study_program => "Sukurti naują studijų programą",
  :new_exchange_program => "Sukurti naują mainų programą",
  :new_activity_area => "Sukurti naują veiklos sritį",

  #activity types
  :full_study => "Pilnos studijos",
  :fullstudy => "Pilnos studijos",
  :exchange_study => "Mainų programa",
  :exchangestudy => "Mainų programa",
  :internship => "Stažuotė / Praktika",

  #page titles
  :user_profile => "Vartotojo profilis",
  :edit_basic_info => "Redaguoti vartotojo profilį",
  #register, login, user profile
  :register => "Registracija",
  :do_register => "Užsiregistruoti",
  :login => "Prisijungti",
  :logout => "Atsijungti",
  :register_button => "Registruotis",
  :login_button => "Prisijungti",
  :enter_your_details => "Įveskite savo duomenis",
  :username => "Vartotojo vardas", 
  :email => "El. paštas",
  :blog_url => "Tinklaraščio adresas",
  :blog_title => "Tinklaraščio pavadinimas",
  :password => "Slaptažodis",

  :remember_me => "Prisiminti duomenis?",
  :update_email => "Atnaujinti el. pašto adresą",
  :update_blog_url => "Atnaujinti tinklaraščio adresą",

  :send => "Siųsti",
  :delete => "Ištrinti",
  :update => "Atnaujinti",
  :cancel => "Atšaukti",
  :create => "Sukurti",
  :close => "Uždaryti",

  #flashes:
  :invalid_username_password => "Neteisingas vartotojo vardas ir/arba slaptažodis",
  :attribute_updated => "atnaujinta(s)",
  :user => "Vartotojas",
  :logged_in => "prisijungė",
  :logged_out => "Atsijungėte sėkmingai",
  :created => "sukurtas",

  #notices:
  :university_is_pending => "Kol svetainės administratorius nepatvirtins naujai sukurto įrašo, jį matysite tik Jūs.<br />Platesnį universiteto aprašymą galėsite sukurti Universitetų sąraše",
  :organization_is_pending => "Kol svetainės administratorius nepatvirtins naujai sukurto įrašo, jį matysite tik Jūs.<br />Platesnį organizacijos aprašymą galėsite sukurti Organizacijų sąraše",
  :study_program_is_pending => "Kol svetainės administratorius nepatvirtins naujai sukurto įrašo, jį matysite tik Jūs.<br />Platesnį studijos programos aprašymą galėsite sukurti studijų programų sąraše",
  :exchange_program_is_pending => "Kol svetainės administratorius nepatvirtins naujai sukurto įrašo, jį matysite tik Jūs.<br />Platesnį mainų programos aprašymą galėsite sukurti mainų programų sąraše",
  :activity_area_is_pending => "Kol svetainės administratorius nepatvirtins naujai sukurto įrašo, jį matysite tik Jūs.<br />Platesnį veiklos srities aprašymą galėsite sukurti veiklos sričių sąraše",
  #blog
  :new_comment => "Naujas komentaras",
  :comments => "Komentarų",
  #comments
  :anonymous => "Anonimas",

  #errors
  :error_saving_university => "Klaida išsaugant. Gal toks universitetas jau yra?",
  :error_saving_organization => "Klaida išsaugant. Gal tokia organizacija jau yra?",
  :error_saving_exchange_program => "Klaida išsaugant. Gal tokia mainų programa jau yra?",
  :error_saving_activity_area => "Klaida išsaugant. Gal tokia veiklos sritis jau yra?",
  :error_saving_study_program => "Klaida išsaugant. Gal tokia studijų programa jau yra?",
  #user
  :select_country => "Pasirinkite šalį",
  :select_university => "Pasirinkite universitetą",
  :select_study_type => "Pasirinkite studijų tipą",
  :select_subject_area => "Pasirinkite studijų sritį",
  :select_study_program => "Pasirinkite studijų programą",
  :select_exchange_program => "Pasirinkite mainų programą",
  :select_activity_area => "Pasirinkite veiklos sritį",

  :select_country_first => "Pirmiausia pasirinkite šalį",
  :select_subject_area_first => "Pirmiausia pasirinkite studijų sritį",

  :current => "Iki dabar",

  #organization_types
  :university => "Universitetas",
  :company => "Įmonė",
  :ngo => "Nevyriausybinė organizacija",
  #custom_errors
  :username_error => "turi susidėti tik iš raidžių, skaičių, brūkšių (-) ir pabraukimo brūkšnių (-)",
  :no_spaces => "neturi turėti tarpų",
  :not_correct => "neteisingas",
  :must_be_valid => "turi būti teisingas",
  :could_not_connect => "Nepavyko gauti įrašų iš išorinio tinklaraščio. Patikrinkite adresą. <br>Rodomi tik sistemoje išsaugoti įrašai.",


  :models => {
      :user => {
        :attributes => {
          :username => "Vartotojo vardas",
          :password => "Slaptažodis",
          :email => "El. pašto adresas",
          :blog_url => "Tinklaraščio adresas",
          }
        }  
  },

  :activerecord => {
    :attributes => {
        :user => {  
          :username => "Vartotojo vardas",
          :password => "Slaptažodis",
          :email => "El. paštas",
          :blog_url => "Tinklaraščio adresas",
        }
    },
    :errors => {
      :template => {
        :header => {
          :one => "Įrašas nebuvo išsaugotas dėl 1 klaidos",
          :other => "Dėl {{count}} klaidų įrašas nebuvo išsaugotas"
        },
        :body => "problemų kilo su šiais laukais:" 
     },
      :messages => {
        :accepted => "must be accepted",
        :blank => "negali būti tuščia", 
        :confirmation => "neatitinka patvirtinimo",
        :empty => "negali būti tuščia", 
        :equal_to => "turi būti lygu {{count}}",
        :even => "turi būti lyginis", 
        :exclusion => "yra rezervuota(s)",
        :greater_than => "turi būti daugiau už {{count}}", 
        :greater_than_or_equal_to => "turi būti daugiau arba lygu {{count}}",
        :inclusion => "nėra sąraše",
        :invalid => "yra neteisinga(s)", 
        :less_than => "turi būti mažiau už {{count}}",
        :less_than_or_equal_to => "turi būti mažiau arba lygu {{count}}",
        :not_a_number => "turi būti skaičius",
        :odd => "turi būti lyginis",
        :taken => "jau yra sistemoje",
        :too_long => "per ilgas (maksimalus ilgis yra {{count}} simbolių)",
        :too_short => "per trumpas (minimalus ilgis yra {{count}} simboliai)",
        :wrong_length => "neteisingo ilgio (turi būti {{count}} simboliai)"
      }
  }
  },


  :time => {
    :formats => {
      :default => "%Y-%m-%d",
      :short => "%m-%d", 
      :long => "%Y-%m-%d %H:%M",
    },
    :am => "am", 
    :pm => "pm" 
   }, 
  
  :date => {
    :formats => {
      :default => "%Y-%m-%d",
      :short => "%b %d",
    },
    :day_names => [ "Pirmadienis", "Antradienis", "Trečiadienis", "Ketvirtadienis", "Penktadienis", "Šeštadienis", "Sekmadienis" ],
    :abbr_day_names => ["Pirm.", "Antr.", "Treč.", "Ketv.", "Penkt.", "Šešt.", "Sekm."],
    # Don't forget the nil at the beginning; there's no such thing as a 0th month
    :month_names => ["~", "Sausio", "Vasario", "Kovo", "Balandžio", "Gegužės", "Birželio", "Liepos", "Rugpjūčio", "Rugsėjo", "Spalio", "Lapkričio", "Gruodžio"],
    :abbr_month_names => ["~", "Saus.", "Vas.", "Kov.", "Bal.", "Geg.", "Birž.", "Liep.", "Rugpj.", "Rugs.", "Spal.", "Lapk.", "Gruod."],
    # Used in date_select and datime_select.
    :order => [ :year, :month, :day ]
  }
}
} 
