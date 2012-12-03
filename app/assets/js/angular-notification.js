'use strict';

angular.module('Notification', []).factory('$flash', function($rootScope) {
    var service = {
        notify : function(level, message, element, callback){
                   var notification =  {
                     level: level,
                     message: message,
                     element: (element || 'default'),
                     callback: callback
                   };
                   $rootScope.$emit("event:ngNotification", notification);
                 }    
        };
    return service;
  }).directive('ngNotice', function($rootScope) {
    var noticeObject = {
       replace: false,
       transclude: false,
       link: function (scope, element, attr){
         $rootScope.$on("event:ngNotification", function(event, notification){
           if (attr.ngNotice == notification.element){  
             element.html("<div class=\"alert-box " + notification.level +
                          "\">" + notification.message + 
                          '<a href="" class="close">&times;</a></div>');
             if (typeof notification.callback === 'function'){
               notification.callback();
             }
           }
         });
         element.attr('ng-notice',(attr.ngNotice || 'default'));
       }
    };
    return noticeObject;  
});
