require 'pg'
require_relative 'database_connection'
require_relative 'database_connection_setup'
class Bookmark

  attr_reader :id, :title, :url

def initialize(id:, title:, url:)
  @id  = id
  @title = title
  @url = url
end

  def self.all
      result = DatabaseConnection.query("SELECT * FROM bookmarks")
      result.map do |bookmark|
        Bookmark.new(
          url: bookmark['url'],
          title: bookmark['title'],
          id: bookmark['id']
        )
      end
    end


    def self.create(url:, title:)
      # return false unless is_url?(url)
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
      result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
      Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    end

def self.delete(id:)

  DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
end

def self.update(id:, url:, title:)
  result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
  Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
end

def self.find(id:)
  result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
  Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
end

end
