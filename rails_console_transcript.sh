1.9.3p125 :002 > first_user = User.first
  User Load (0.1ms)  SELECT "users".* FROM "users" LIMIT 1
 => #<User id: 1, username: "supercoolguy", name: "Super Cool Guy", email: "supercool@coolest.com", dob: 1990, acctype: "lame", created_at: "2012-06-05 19:00:22", updated_at: "2012-06-05 19:00:22"> 
1.9.3p125 :004 > first_user.narratives
  Narrative Load (0.2ms)  SELECT "narratives".* FROM "narratives" WHERE "narratives"."user_id" = 1
 => [#<Narrative id: 1, event_id: 1, user_id: 1, name: "My time with fluffy...", location: "Kitten Land", content: "Fluffy was an adorable black kitten. It also has th...", created_at: "2012-06-05 19:51:20", updated_at: "2012-06-05 19:51:20">] 
1.9.3p125 :005 > first_event = Event.first
  Event Load (0.2ms)  SELECT "events".* FROM "events" LIMIT 1
 => #<Event id: 1, name: "Kitten Party", start_date: "2012-06-05", end_date: "2012-06-07", status: "ongoing with completion date", summary: "Important worldwide event where everyone learns to ...", created_at: "2012-06-05 19:44:37", updated_at: "2012-06-05 19:44:37"> 
1.9.3p125 :006 > first_event.narratives
  Narrative Load (0.3ms)  SELECT "narratives".* FROM "narratives" WHERE "narratives"."event_id" = 1
 => [#<Narrative id: 1, event_id: 1, user_id: 1, name: "My time with fluffy...", location: "Kitten Land", content: "Fluffy was an adorable black kitten. It also has th...", created_at: "2012-06-05 19:51:20", updated_at: "2012-06-05 19:51:20">] 
1.9.3p125 :009 > narrative = Narrative.new :content => "Once upon a time...", :event_id => 2, :user_id => 1, :location => "Moon", :name => "Moonwalking Cats"
 => #<Narrative id: nil, event_id: 2, user_id: 1, name: "Moonwalking Cats", location: "Moon", content: "Once upon a time...", created_at: nil, updated_at: nil> 
1.9.3p125 :010 > narrative.save
   (0.1ms)  begin transaction
  SQL (5.2ms)  INSERT INTO "narratives" ("content", "created_at", "event_id", "location", "name", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?, ?, ?)  [["content", "Once upon a time..."], ["created_at", Wed, 06 Jun 2012 17:52:02 UTC +00:00], ["event_id", 2], ["location", "Moon"], ["name", "Moonwalking Cats"], ["updated_at", Wed, 06 Jun 2012 17:52:02 UTC +00:00], ["user_id", 1]]
   (44.1ms)  commit transaction
 => true 
1.9.3p125 :011 > user2 = User.new :acctype => "moderator", :dob => 1890, :email => "funky@chunky.com", :name => "Funky Monkey", :username => "funkymonkey"
 => #<User id: nil, username: "funkymonkey", name: "Funky Monkey", email: "funky@chunky.com", dob: 1890, acctype: "moderator", created_at: nil, updated_at: nil> 
1.9.3p125 :012 > user2.save                                                                            (0.1ms)  begin transaction
  SQL (1.1ms)  INSERT INTO "users" ("acctype", "created_at", "dob", "email", "name", "updated_at", "username") VALUES (?, ?, ?, ?, ?, ?, ?)  [["acctype", "moderator"], ["created_at", Wed, 06 Jun 2012 18:00:15 UTC +00:00], ["dob", 1890], ["email", "funky@chunky.com"], ["name", "Funky Monkey"], ["updated_at", Wed, 06 Jun 2012 18:00:15 UTC +00:00], ["username", "funkymonkey"]]
   (278.0ms)  commit transaction
 => true
1.9.3p125 :015 > user2.name
 => "Funky Monkey"
1.9.3p125 :016 > narrative.content
 => "Once upon a time..." 