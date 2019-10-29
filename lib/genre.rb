require_relative "../lib/concerns/concerns_module.rb"
class Genre
  extend Concerns::Findable
  
  attr_accessor :name
  
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << Genre.new(name)
  end
  
  def self.create(name)
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end  
  
  def songs
    @songs
  end
  
  def artists
    self.songs.collect {|song| song.artist}.uniq
  end
  
  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.genre = self unless song.genre
  end
  
end