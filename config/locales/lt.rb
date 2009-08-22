# Sample localization file for Lithuanian. Add more files in this directory for other locales.
# See http://github.com/svenfuchs/rails-i18n/tree/master/rails%2Flocale for starting points.
{
:lt => {
  :mydate => "Data",
  :title => "Pavadinimas",
  :body => "Body?",
  #register, login, user profile
  :register => "Registracija",
  :login => "Prisijungti",
  :register_button => "Registruotis",
  :login_button => "Prisijungti",
  :enter_your_details => "Įveskite savo duomenis",
  :username => "Vartotojo vardas", 
  :email => "El. paštas",
  :password => "Slaptažodis",
  :remember_me => "Prisiminti mane?",
  #blog
  :new_comment => "Naujas komentaras",
  :comments => "Komentarų",
  #comments
  :anonymous => "Anonimas",

  :models => {
      :user => {
        :attributes => {
          :username => {
            :too_short => "per trumpas"
            }
          }
        }  
  },

  :activerecord => {
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
        :greater_than_or_equal_to => "turi būti daugiau arba lugy {{count}}",
        :inclusion => "nėra sąraše",
        :invalid => "yra neteisinga(s)", 
        :less_than => "turi būti mažiau už {{count}}",
        :less_than_or_equal_to => "turi būti mažiau arba lygu {{count}}",
        :not_a_number => "turi būti skaičius",
        :odd => "turi būti lyginis",
        :taken => "jau užimtas",
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
