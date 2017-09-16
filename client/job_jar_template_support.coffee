Meteor.autorun ->
  Meteor.subscribe('tasks')
  Meteor.subscribe('parents', Meteor.userId())
  Meteor.subscribe('children')
  Meteor.subscribe('myTasks', Meteor.userId())
  Meteor.subscribe('profile', Meteor.userId())
  Meteor.subscribe('userData', Meteor.userId())

Meteor.startup ->

Handlebars.registerHelper = (title) ->
  if (title)
    document.title = title
  else
    document.title = "Job Jars"

Template.register.events
  'click #registerFormBtn' : (event) ->
    event.preventDefault()
    username = $('#newUsername').val()
    name = $('#newUserFirstName').val()
    password = $('#newUserPassword').val()
    email = $('#newUserEmail').val()
    password2 = $('#newUserConfirmPassword').val()

    if (password != password2)
      alert('Passwords must match')
    else
      Accounts.createUser({
          username: username,
          email:    email,
          password: password,
          profile: {
            name: name
            role: "parent"
          }
      })
      Router.go('home_page')
    Account.createUser()

Template.homePage.events
  'click #registerBtnHomePage': (e, t) ->
    e.preventDefault()
    Router.go('register')

Template.loginPage.events
  #'click #btnLoginGoogle' : (e, t) ->
  #  e.preventDefault()
  #  Meteor.loginWithGoogle()
  ,
  #'click #btnLoginFacebook' : (e,t) ->
  #  e.preventDefault()
  #  #Meteor.loginWithFacebook()
  #,
  'click #btnLoginPassword' : (e, t) ->
    e.preventDefault()
    $('#login-form-div').toggle()
  ,
  'click #login-button' : (e, t) ->
    e.preventDefault()
    email = $('#login-email').val()
    password = $('#login-password').val()
    alert email
    Meteor.loginWithPassword(email, password, (e) ->
      if (e)
        sweetAlert {title: "Oops", text: "There was a problem with your login. Please try again.", type: "error"}
      else
        alert 'Logged in'
    )
  ,
  'click #cancel-login-button' : (e, t) ->
    e.preventDefault()
    $('#login-form-div').hide()


Template.navbar.helpers
  'isParent': ->
    if Meteor.user().profile.role is "parent"
      return true
    else
      return false

Template.chores.events
  'click #addTask': (event) ->
    $('#newTask').toggle()
  ,
  'click .portlet-toggle': (event) ->
    icon = $(this)
    icon.toggleClass("ui-icon-minusthick ui-icon-plusthick")
    icon.closest(".portlet").find(".portlet-content").toggle()

Template.chores.rendered = ->
  $('#newTask').hide()

Template.myChores.rendered = ->

Template.choresDone.helpers
  'choresDone': ->
      return Tasks.find({'status': 'Done'})

Template.myChores.helpers
  'tasks': ->
    return Tasks.find({available: true})
  ,
  'mines': ->
    return Children.find({userId: Meteor.userId()})
  ,
  'dones': ->
    return Children.find({}, {fields: {'completedTasks':1}})

Template.my_task.helpers
    'task': ->
      return this['myTasks'][0]['task']

    'task_id': ->
      return this['myTasks'][0]['task_id']

    'desc': ->
      return this['myTasks'][0]['desc']

    'value': ->
      return this['myTasks'][0]['value']

Template.myChores.events
  'dragstart .chore': (e) ->
      e.dataTransfer = e.originalEvent.dataTransfer
      e.dataTransfer.setData('text', e.target.id)
  ,
  'dragover #available-chores,#jar,#mine': (e) ->
      e.preventDefault();
  ,
  'drop #available-chores,#jar,#mine': (e) ->
      e.dataTransfer = e.originalEvent.dataTransfer
      id = e.dataTransfer.getData('text')
      elementID = document.getElementById(id)
      validNodes = ['jar', 'mine', 'available-chores']
      if (e.target.id in validNodes)
          e.target.appendChild(elementID)
          targetID = e.target.id
      else if (e.target.parentNode in validNodes)
          e.target.parentNode.appendChild(elementID)
          targetID = e.target.parentNode.id

      e.preventDefault()

Template.children.events
    'click #addChild' : (event) ->
      $('#newChild').toggle()

Template.children.helpers
    'child': ->
        return Children.find({childOf: Meteor.userId()})

Template.children.rendered = ->
    $('#newChild').hide()

Template.childrenList.helpers
    'child': ->
      return Children.find({childOf: Meteor.userId()})

Template.childrenList.events
  'click #addChild' : (event) ->
    $('#newChild').toggle()

Template.rewardsEarned.rendered = ->

Template.rewardsEarned.events
    'click .btn': (e, t) ->
        e.preventDefault()
        alert('Reward button clicked')

Template.addTask.events
    'submit': ->
        alert($('#taskDesc').val())

Template.addChild.events

Template.addChild.events
    'click #btnAddChild' : (e, t) ->
        e.preventDefault();
        name = $('#childName').val()
        dob = $('#childDob').val()
        username = $('#childUserName').val()
        password = $('#childPassword').val()
        Meteor.call( 'createChild', name, username, password, dob, Meteor.userId())

        $('#newChild').hide()
    ,
    'click #closeAddChildBox' : (e) ->
      e.preventDefault()
      $('#newChild').hide()

Template.chores.helpers
  tasks: ->
      myParentId = Children.find({_id: Meteor.userId()}, {fields : {_id: 0, childOf: 1}})
      return Tasks.find({createdBy: myParentId})

$( ".column" ).sortable(
    connectWith: ".column",
    handle: ".portlet-header",
    cancel: ".portlet-toggle",
    start: (event, ui) ->
        ui.item.addClass('tilt');
        tilt_direction(ui.item);
    ,
    stop: (event, ui) ->
        ui.item.removeClass("tilt")
        $("html").unbind('mousemove', ui.item.data("move_handler"))
        ui.item.removeData("move_handler")
)


$( ".portlet" )
  .addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
  .find( ".portlet-header" )
  .addClass( "ui-widget-header ui-corner-all" )
  .prepend( "<span class='ui-icon ui-icon-minusthick portlet-toggle'></span>")



Template.profile.helpers
  'name' : ->
    if (Meteor.user().services.google)
      Meteor.user().services.google.name
    else if Meteor.user().services.password
      Meteor.user().profile.name
  ,
  'email' : ->
    if (Meteor.user().services.google)
      Meteor.user().services.google.email
    else if Meteor.user().services.password
      Meteor.user().emails[0]['address']

Template.profile.events
  'click #btn-edit-profile': ->
    Router.go('editProfile')



Template.coming_soon.rendered = ->
  $('.navbar').hide()
  $('body').css('background-image', "url('/child_raking.jpg')")
  $('body').css('background-repeat', 'no-repeat')
  $('body').css('background-color', '#ffffff')