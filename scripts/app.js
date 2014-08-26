define([
    'angular',
    'animations',
    'controllers',
    ], function (angular, animations, controllers) {
        return angular.module('graph', [
            'ngAnimate',
            'graph.animations',
            'graph.controllers'
        ]);
});