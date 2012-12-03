@NightUp = angular.module('Myapp', ['ngResource'])
  .config(['$routeProvider', ($route) ->
    $route.when('/sessions', {
      controller: 'SessionCtrl',
      templateUrl:  'templates/sessions/login.html'
    })
    $route.otherwise({redirectTo: '/wall'})
  ]).
  run(['$rootScope', '$flash', '$q',($rootScope, $flash, $q) ->
    $rootScope.resourceError = (response) ->
       deferred = $q.defer()
       if response.status is 404
         $rootScope.resourceError404(response)
       if response.status is 422
         $rootScope.resourceError422(response)
       if response.status is 500
         $rootScope.resourceError500(response)
       if response.status is 401
         req =
           config: response.config
           deferred: deferred
         $rootScope.requests401 = req
         $rootScope.resourceError401(response)
       return deferred.promise

    $rootScope.resourceError404 = (response) ->
      alert 'Page Not Found'
    $rootScope.resourceError422 = (response) ->
      alert response.data.error
    $rootScope.resourceError500 = (response) ->
      alert "Ooops. Something bad happened. Please, try again!"
    $rootScope.resourceError401 = (response) ->
      $rootScope.$broadcast('event:loginRequired')
  ]).
  run(($rootScope) ->
    $rootScope.environment = @Environment
    $rootScope.client_type = @ClientType
    $rootScope.access_token = '' if @Emulator is  'emulator'
  ).
  config(($httpProvider) ->
    interceptor = ['$rootScope','$q', (scope, $q) ->
      success = (response) ->
        response
      error = (response) ->
        return scope.resourceError(response)
        $q.reject(response)
      (promise) ->
        promise.then(success, error)
      ]
    $httpProvider.responseInterceptors.push(interceptor)
  ).
  run(['$rootScope', ($rootScope) ->
    $rootScope.$on 'event:loginRequired',(event) ->
    $rootScope.$on 'event:loginConfirmed',(event, response) ->
    $rootScope.$on 'event:logoutConfirmed' , (event) ->
    ping = () ->
        "ping"
    ping()
  ])
