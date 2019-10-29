require_relative "../lib/concerns/concerns_module.rb"
require 'pry'
class Song
  extend Concerns::Findable
  
  
  attr_accessor :name, :artist, :genre
  
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
    @@all << self
  end
  
  def self.all
    @@all
  end  
  
  def self.destroy_all
    @@all = []
  end 
  
  def save
    @@all << self
  end
  
  def self.create(name)
    create_song = Song.new(name)
    create_song.save
    create_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) 
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end

  # def self.find_by_name(song_name)
  #   @@all.find {|song| song.name == song_name}
  # end
  
  # def self.find_or_create_by_name(song_name)
  #   if self.find_by_name(song_name)
  #     self.find_by_name(song_name)
  #   else
  #     self.create(song_name)
  #   end
  # end

  def self.new_from_filename(filename)
    fileconv = filename.split(" - ")
    fileconv_ = fileconv[2].split(".")
   
    song_file = Song.find_or_create_by_name(fileconv[1])#, artist_file, genre_file)
    artist_file = Artist.find_or_create_by_name(fileconv[0])
    genre_file = Genre.find_or_create_by_name(fileconv_[0])
    
    
    song_file.artist = artist_file
    song_file.genre = genre_file
    
    song_file
    # binding.pry
   
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
  

end