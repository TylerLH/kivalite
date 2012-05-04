# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$.ajax
		url: '/loans/newest.json'
		success: (response) ->

			first_loan = response.loans[0]

			# create the loans/selected loan viewmodel
			class loansViewModel

				filter:
					country: ko.observable()
					sector: ko.observableArray([])

				currentPage: ko.observable(response.paging.page)
				loans: ko.observableArray(response.loans)

				selectedLoan:
					name: ko.observable(first_loan.name)
					image: ko.observable(first_loan.image.id)
					activity: ko.observable(first_loan.activity)
					sector: ko.observable(first_loan.sector)
					location:
						town: ko.observable(first_loan.location.town)
						country: ko.observable(first_loan.location.country)

				updateLoans: =>
					$.ajax
						url: '/loans/search.json'
						data:
							country: @filter.country
							sector: @filter.sector
						success: (response) =>
							if response.loans.length > 0
								@loans.removeAll()
								@selectLoan(response.loans[0])
								$(response.loans).each (i,loan) =>
									@loans.push loan
							else
								alert 'no loans found'

				loadMore: =>
					$.ajax
						url: '/loans/search.json'
						data:
							page: @currentPage + 1
						success: (response) =>
							console.log response

				selectLoan: (loan) =>
					@selectedLoan.name(loan.name).image(loan.image.id)
					@selectedLoan.location.town(loan.location.town).country(loan.location.country)

			# bind loans viewmodel to div#main
			loansvm = new loansViewModel()
			ko.applyBindings(loansvm,document.getElementById('main'))
			loansvm.filter.country.subscribe (newVal) ->
				loansvm.updateLoans()