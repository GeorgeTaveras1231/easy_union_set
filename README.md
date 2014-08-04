[easy_union_set](https://rubygems.org/gems/easy_union_set)
==============

easily create unions and intersections in ActiveRecord.

Easy to use, So I'll jump straight into the examples

to create a UNION
```ruby
Project.where("title LIKE '%a%'") | Project.having("LENGTH(description) > 10").group(:id)

# =>
  SELECT "projects".* FROM ( SELECT "projects".* FROM "projects"  WHERE (title LIKE '%a%') UNION SELECT "projects".* FROM "projects"  GROUP BY id HAVING LENGTH(description) > 10 ) "projects"
```

to create an INTERSECT
```ruby
Project.where("title LIKE '%a%'") & Project.having("LENGTH(description) > 10").group(:id)

# =>
  SELECT "projects".* FROM ( SELECT "projects".* FROM "projects"  WHERE (title LIKE '%a%') INTERSECT SELECT "projects".* FROM "projects"  GROUP BY id HAVING LENGTH(description) > 10 ) "projects"
```

to create a UNION ALL
```ruby
Project.where("title LIKE '%a%'") | {:all => Project.having("LENGTH(description) > 10").group(:id)}

SELECT "projects".* FROM ( SELECT "projects".* FROM "projects"  WHERE (title LIKE '%a%') UNION ALL SELECT "projects".* FROM "projects"  GROUP BY id HAVING LENGTH(description) > 10 ) "projects"
```