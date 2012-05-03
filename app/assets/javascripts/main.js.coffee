# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$.ajax
		url: '/loans/newest.json'
		success: (response) ->
			class loansViewModel
				loans: ko.observableArray(response.loans)
				selectedLoan:
					name: ko.observable(response.loans[0].name)
					image: ko.observable(response.loans[0].image.id)

			ko.applyBindings(new loansViewModel(),document.getElementById('main'))