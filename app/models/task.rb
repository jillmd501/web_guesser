require 'sqlite3'

attr_reader :title, :description

class Task
  def initialize(task_params)
    @description = task_params["description"]
    @title       = task_params["title"]
    @database = SQLite3::Database.new('db/task_manager_development.db')
	@database.results_as_hash = true
  end

  def self.all
	database = SQLite3::Database.new('db/task_manager_development.db')
	database.results_as_hash = true
	tasks = database.execute("SELECT * FROM tasks")
	tasks.map do |task|
	  Task.new(task)
	end
  end

  def self.find(id)
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    task = database.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(task)
  end
end