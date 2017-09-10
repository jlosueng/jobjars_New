Meteor.publish('myTasks', (userID) ->
  return Children.find({childId: userID}, {fields: { 'myTasks.task_id': true}});
)

Meteor.publish('children', ->
  return Children.find()
)

Meteor.publish('userData', (userID) ->
  return Meteor.users.find({_id: userID}, {fields: {emails: 1, services: 1}})
)


Meteor.publish('tasks', ->
  return Tasks.find()
)

Meteor.publish('parents', (userID) ->
  return Parents.find({parentID: userID})
)

Meteor.publish('profile', (userID) ->
  return Profile.find({belongsTo: userID})
)

Meteor.methods({
  createChild: (childName, childUserName, childPasswd, childDob, parentId) ->
    Accounts.createUser({
      username: childUserName
      password: childPasswd
      profile: {
        name: childName
        role: "child"
      }
    })
    userId = Meteor.users.findOne({username: childUserName})._id
    Children.insert({
      childId: userId
      name: childName
      dob: childDob
      childOf: parentId
    })
})
