include DataMapper::Sweatshop::Unique # Use DataMapper::Sweatshop.unique if you don't want to pollute your namespace

User.fixture {{
    :login => (login = unique(:login) { /\w+/.gen }),
    :password => (password = /\w+/.gen),
    :password_confirmation => password
  }}

Article.fixture {{
    :title => (unique(:title) { /[:sentence:]/.gen[0..255] }),
    :published => true,
    :body => (/[:sentence:]/.gen),
    :user => User.make
  }}
