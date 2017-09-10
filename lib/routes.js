Router.configure({
    layoutTemplate: 'layout',
    notFoundTemplate: 'notFound',
    loadingTemplate: 'loading' ,
    yieldRegions: {
        'sidenav' : {to: 'sidenav'},
        'fixedFooter': {to: 'footer'},
        'navbar': {to: 'navbar'}
    }
});

Router.onBeforeAction('loading');

Router.map(function() {
    this.route('home_page', {
        path: '/',
        action: function () {
            if (Meteor.userId()) {
                Router.go('overview');
            }
            else {
                this.render();
            }
        }
    });
    this.route('overview', {
        path: '/overview',
        waitOn: function () {

        },
        data: function () {
            return Tasks.find();
            return People.find();
        },
        action: function() {
            if (Meteor.userId()) {
                this.render();
            }
            else {
                Router.go('login');
            }
        }
    });
    this.route('children');
    this.route('loggedout', {
        path: '/goodbye'
    });
    this.route('login', {
        template: 'loginPage',
        action: function () {
            if (Meteor.userId()) {
                Router.go('myChores');
            }
            else {
                this.render();
            }
        }
    });

    this.route('editProfile');

    this.route('register', {
        action: function () {
            if (Meteor.userId()) {
                Router.go('overview');
            } else {
                this.render();
            }

        }
    });
    this.route('logout', {
        action: function () {
            Meteor.logout();
            Router.go('loggedout');
        }
    });
    this.route('myChores');
    this.route('taskDetail', {
        path: '/task/:_id',
        waitOn: function () {
            return Meteor.subscribe('tasks', this.params._id)
        },
        data: function () {
            return Tasks.findOne({'_id': this.params._id})
        }
    });
    this.route('chores', {
        action: function () {
            if (!Meteor.userId()) {
                Router.go('login');
            }
            else if (this.ready()) {
                this.render();
            }
            else {
                this.render('loading');
            }
        }
    });
    this.route('profile', {
        action: function () {
            if (!Meteor.userId()) {
                Router.go('login');
            }
            else if (this.ready()) {
                this.render();
            }
            else {
                this.render('loading');
            }
        }
    });

    this.route('about');
    this.route('child', {
        path: '/child/:_id'
    });
    this.route('notFound', {path: '*'});
    this.route('addTask', {
        action: function () {
            if (!Meteor.userId()) {
                Router.go('login');
            }
            else if (this.ready()) {
                this.render();
            }
            else {
                this.render('loading');
            }
        }
    });
    this.route('addChild', {
        action: function () {
            if (!Meteor.userId()) {
                Router.go('login');
            }
            else if (this.ready()) {
                this.render();
            }
            else {
                this.render('loading');
            }
        }
    });
})
