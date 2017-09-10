/**
 * Created by joe on 6/5/2014.
 */

/*
Tasks = {createdBy, _id, task: short desc, desc: long description, frequency: [Daily, Weekly, Monthly], value: float, minAge: int, available: boolean, lastComplete: date, history[list of dates], lastCompletedBy: userID, nextAvailDate: date}
People = {_id, userId, myTasks; [list of taskIDs], completedTasks[list of taskIDs], rewardsOwed: value, rewardsPaidToDate: value;
Profile = {_id, createdBy: parentuserid, rewardType: [cash, points}
Users = { username: username, emails: [], profile: {name: [First], dob: date, role: {child: child_of[], parent: parent_of[]},
 */

try {
    Tasks = new Meteor.Collection("tasks");
}
catch(err) {
    console.log("error caught");
}
Children = new Meteor.Collection("children");
Parents = new Meteor.Collection("parents");
Profile = new Meteor.Collection("profile");

/*
ServiceConfiguration.configurations.remove({
    service: "google"
});

ServiceConfiguration.configurations.remove({
    service: "facebook"
});

ServiceConfiguration.configurations.insert({
    service: "google",
    clientId: "940377676441-pg790qcleniuo76e1bo5tqa70pnsokot.apps.googleusercontent.com",
    secret: "8QXwCcANEgXeP4R3AnKR661-"
});

if (Tasks.find().count() === 0) {
    Tasks.insert({
        task_id: 'task_1',
        createdBy: 'JZshkYg5L2HHd8HKk',
        task: 'Sweep kitchen',
        desc: 'Sweep the wood floor from the pantry to the kitchen table',
        frequency: 'Daily',
        value: '5',
        minAge: '9',
        available: true,
        lastCompletionDate: '',
        history: [],
        lastCompletedBy: '',
        nextAvailDate: ''
    });
    Tasks.insert({
        task_id: 'task_2',
        createdBy: 'JZshkYg5L2HHd8HKk',
        task: 'Pick up your bedroom',
        desc: 'Dirty clothes in the hamper, items off the floor, clean off your dresser',
        frequency: 'Daily',
        value: '5',
        minAge: '5',
        available: false,
        lastCompletionDate: '',
        history: [],
        lastCompletedBy: 'jlofshult@gmail.com',
        nextAvailDate: ''
    });
    Tasks.insert({
        task_id: 'task_3',
        createdBy: 'JZshkYg5L2HHd8HKk',
        task: 'Change your sheets',
        desc: 'Strip the sheets off your bed and put in hamper. Put clean sheets on the bed',
        frequency: 'Weekly',
        value: '5',
        minAge: '10',
        available: true,
        lastCompletionDate: '',
        history: [],
        lastCompletedBy: 'jlofshult@gmail.com',
        nextAvailDate: ''
    });

};

if (People.find().count() == 0) {
    People.insert({
        userId: 'klofshult',
        name: 'Kelsey Lofshult',
        myTasks: [],
        completedTasks: [],
        rewardsEarned: 5,
        rewardsOwed: 0,
        rewardsEarnedToDate: 0,
        rewardsPaidToDate: 0
    });
};

if (Profile.find().count() == 0 ) {
    Profile.insert({
        createdBy: 'JZshkYg5L2HHd8HKk',
        rewardtype: 'points'
    })
}
*/