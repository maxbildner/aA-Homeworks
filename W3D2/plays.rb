require 'sqlite3'
require 'singleton'   # we only want one instance of the PlayDB or play class?
require 'byebug'

# Note* PlayDBConnection class accesses the database stored 
# in plays.db (which includes BOTH plays and playwrights tables)
class PlayDBConnection < SQLite3::Database    # ?
  include Singleton

  def initialize                      
    super('plays.db')                 # plays.db has all the tables
    self.type_translation = true      # makes sure all the data we get back is same as data passed in
    self.results_as_hash = true       # easier to manipulate if data comes back as a hash (instead of an array)
  end
end

class Play                            # ?object that represents play table w/ attributes that refer to table columns?
  attr_accessor :id, :title, :year, :playwright_id    # changes the value of that instance (column)
  # an instance of play will represent a single row!

  def self.all                        # show us every entry we have in our play database
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    # ^pulls all of the information out from of our plays table (in play.db)
    # .instance because (singleton)   .execute("") lets us execute SQL code
    # ?but data is an array of HASHES, so we want to map across that data
    # each subarr represents a row
    # ex. data = [{"id"=>1, "title"=>"All My Sons", "year"=>1947, "playwright_id"=>1}, {"id"=>2, "title"=>"Long Day's Journey Into Night", "year"=>1956, "playwright_id"=>2}]
    
    data.map { |datum| Play.new(datum) }
    # ex. [#<Play:0x00007fe49b95c090 @id=1, @playwright_id=1, @title="All My Sons", @year=1947>,
 #<Play:0x00007fe49c2ac0c8 @id=2, @playwright_id=2, @title="Long Day's Journey Into Night", @year=1956>]

    # ?this returns an array of play class instances (datum == column in database)
    # instances of the class represent rows, but the class itself reprsents the whole table
  end

  def self.find_by_title(title)       # query to find row by tile

  end

  def self.find_by_playwright(name)   # returns all plays written by playwright
  end

  def initialize(options)             # new instance of the play class
    # ^passing in an options hash. the options hash will come in one of two ways:
    # ex. options = { 'id'=> , 'title'=> , 'year'=> , 'playwright_id'=> }
    #       1- from the (self.all) Play::all class method
    #          ?but I thought the self.all returns an array?!
    #       2- ?a user could pass it in?

    # now we're pulling out all of the data in the hash
    @id = options['id']         # ?gives us integer primary id? or entire column of primary ids?
    @title = options['title']   # ?
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create                          # save that play instance to our database
    raise "#{self} already in database" if self.id
    # if id is NOT nil, raise an error

    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      -- heredoc = <<-  runs sql code
      -- ?sql gem allow us to pass "bind" arguments?
      -- instance method for generating a new row ex. Play.new({'title'=> 'hamlet', 'year'=>1980, 'playwright_id'=> 8} )
      INSERT INTO
        plays (title, year, playwright_id)    -- insert into plays columns
        -- inserting values in table 
      VALUES
        (?, ?, ?)
        --(#{title}, year, playrwright_id)
        -- 1st ? will pull in value from 1st bind argument, and 2nd ? will also do the same for 2nd arg...
        -- use ? instead of ex. @title
        -- '?' prevents sql injection attacks
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
    # .last_insert_row_id gets us the id of the last row and inserted into the database
    # assigns auto pr
  end

  def update                          # lets us update info in the play table (incase we screw up)
    raise "#{self} not in database" unless self.id
    # raise an error if self (play object) is not in database

    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
    -- ?is this updating an entire row values? or ?column names?
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end


class Playwright
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")   # pretty same as Play self.all
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless person.length > 0 

    Playwright.new(person.first)
  end

  def initialize
  end

  def create
  end

  def update
  end

  def get_plays     # returns all plays written by playwright?
  end
end

# playwrights table schema:
# INSERT INTO
#   playwrights (name, birth_year)
# VALUES
#   ('Arthur Miller', 1915),
#   ('Eugene O''Neill', 1888);
