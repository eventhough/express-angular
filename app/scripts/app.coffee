'use strict'

angular.module('expressAngular', []).config(($routeProvider) ->
    $routeProvider.when('/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      ).otherwise(
        redirectTo: '/'
      )
  )
