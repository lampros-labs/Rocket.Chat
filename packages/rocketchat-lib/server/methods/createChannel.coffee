Meteor.methods
	createChannel: (name, members) ->

		check name, String
		check members, [String]

		if not Meteor.userId()
			throw new Meteor.Error 'error-invalid-user', "Invalid user", { method: 'createChannel' }

		if RocketChat.authz.hasPermission(Meteor.userId(), 'create-c') isnt true
			throw new Meteor.Error 'error-not-allowed', "Not allowed", { method: 'createChannel' }

		return RocketChat.createRoom('c', name, Meteor.user()?.username, members);
