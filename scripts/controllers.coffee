define ['jquery', 'angular', 'data'], ($, angular, Data) ->
  app = angular.module 'graph.controllers', []

  app.controller 'AppController', ($scope, $timeout) ->
    $scope.dataUsed = 'ppp'
    $scope.countries = Data
    $scope.sortKeyword = 'key'
    $scope.occupations = getOccupations()

    graphData = (name, data) ->
      if $scope.activeTab is name
       $scope.activeTab = undefined
       return

      applyNewData = ->
        $scope.activeTab = name
        $scope.graphArr = data

      if $scope.activeTab is undefined
        do applyNewData
      else
        $scope.activeTab = undefined
        $timeout applyNewData, 250

    $scope.updateDataUsed = (type) ->
      $scope.dataUsed = type
      if $scope.sortKeyword isnt 'key'
        $scope.sortKeyword = "-#{type}"

    $scope.updateKeyword = (input) ->
      if input is 'key'
        $scope.sortKeyword = 'key'
      else
        $scope.sortKeyword = '-'+$scope.dataUsed

    $scope.toggleCountry = (country) ->
      $scope.dataType = 'country'
      countryName = country['Country']
      countryData = getCountryData(country)
      graphData(countryName, countryData)

    $scope.toggleOccupation = (occupation) ->
      $scope.dataType = 'occupation'
      occupationName = occupation
      occupationData = getOccupationData(occupation)
      graphData(occupationName, occupationData)

    return
  
  getOccupations = ->
    occupations = []
    for own key, value of Data[0]
      occupations.push(key)
    occupations.shift()
    occupations

  getOccupationData = (occupation) ->
    occupationData = []
    for countryObj in Data
      if countryObj[occupation]?
        obj = {}
        obj.key = countryObj.Country

        arr = countryObj[occupation]
        obj.ppp = arr[0]
        obj.actual = arr[1]
        occupationData.push(obj)
    occupationData

  getCountryData = (country) ->
    countryData = []
    for own job, salary of country
      if typeof salary is 'object' &&  salary?
        obj = {}
        obj.key = job

        arr = salary
        obj.ppp = arr[0]
        obj.actual = arr[1]
        countryData.push(obj)
    countryData

  return app