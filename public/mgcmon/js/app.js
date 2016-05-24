var glancesApp = angular.module('glancesApp', ['ngRoute'])

.config(function($routeProvider, $locationProvider) {
    $routeProvider.when('/web/mgcmon', {
        templateUrl : '/mgcmon/html/stats.html',
        controller : 'statsController'
    }).when('/web/mgcmon/:refresh_time', {
        templateUrl : '/mgcmon/html/stats.html',
        controller : 'statsController'
    });

    $locationProvider.html5Mode(true);
});
