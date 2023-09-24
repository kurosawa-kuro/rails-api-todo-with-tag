3.times do |i|
    Todo.create(title: "Todo#{i + 1}")
    Tag.create(name: "Tag#{i + 1}")
  end
  
Todo.all.each do |todo|
    Tag.all.each do |tag|
        TodoTag.create(todo: todo, tag: tag)
    end
end