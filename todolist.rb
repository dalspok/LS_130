# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "can only add Todo objects" unless todo.class == Todo
    @todos << todo
    self
  end

  def <<(todo)
    add(todo)
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    raise IndexError if index >= @todos.size
    @todos[index]
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def each
    counter = 0
    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    selected_list = TodoList.new("selected list")
    each do |todo|
      selected_list << todo if yield todo
    end
    selected_list
  end

  def to_s
    text = "---- #{@title} ----\n"
    @todos.each { |todo| text << "#{todo}\n" }
    return text
  end

  def find_by_title(title)
    each do |todo|
     return todo if todo.title == title
    end
    nil
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select {|todo| !todo.done?}
  end

  def mark_done(title)
    todo = find_by_title(title)
    todo.done! if todo
  end

  def mark_all_done
    each {|todo| todo.done!}
  end

  def mark_all_undone
    each {|todo| todo.undone!}
  end

  def to_a
    @todos
  end
end


