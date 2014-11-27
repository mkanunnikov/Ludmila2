
dependencies = [
    'ngRoute',
    'ui.bootstrap',
    'myApp.filters',
    'myApp.services',
    'myApp.controllers',
    'myApp.directives',
    'myApp.common',
    'myApp.routeConfig'
]

app = angular.module('myApp', dependencies)

angular.module('myApp.routeConfig', ['ngRoute'])
    .config ($routeProvider) ->
        $routeProvider
            .when('/', {
                templateUrl: '/assets/partials/view.html'
            })
            .when('/order/create', {
                templateUrl: '/assets/partials/create.html'
            })
            .otherwise({redirectTo: '/'})

app.config(($logProvider)-> $logProvider.debugEnabled(true))

app.factory("Order", ->
  order = {}
  set = (data) ->
      order = data
  get = ->
      order
  {set:set,get:get}
)

#app.factory("Test", ->
#  test = 'TEST'
#  set = (data) ->
#      test = data
#  get = ->
#      test
#  {set:set,get:get}
#)

@commonModule = angular.module('myApp.common', [])
@controllersModule = angular.module('myApp.controllers', [])
@servicesModule = angular.module('myApp.services', [])
@modelsModule = angular.module('myApp.models', [])
@directivesModule = angular.module('myApp.directives', [])
@filtersModule = angular.module('myApp.filters', [])