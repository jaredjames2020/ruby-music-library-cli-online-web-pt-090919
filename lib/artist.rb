require_relative "../lib/concerns/concerns_module.rb"
class Artist
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
    @@all << Artist.new(name)
  end
  
  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end  
  
  def songs
    Song.all.select {|song| song.artist = self} 
  end
  
  def add_song(song)
    if song.artist != self
      self.songs.collect {|song| song.artist} 
      @songs << song unless @songs.include?(song)
    end 
  end
  
  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

end