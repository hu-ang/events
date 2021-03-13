# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Events.Repo.insert!(%Events.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Events.Repo
alias Events.Users.User
alias Events.Happenings.Happening

jessie = Repo.insert!(%User{email: "jessie", name: "jessie", photo_hash: ""})
annie = Repo.insert!(%User{email: "annie", name: "annie", photo_hash: ""})

Repo.insert!(%Happening{user_id: jessie.id, date: ~N[2000-01-01 23:00:00], name: "yeet", description: "hello"})
Repo.insert!(%Happening{user_id: annie.id, date: ~N[2000-01-01 23:00:00], name: "annie's event", description: "flipping over"})

