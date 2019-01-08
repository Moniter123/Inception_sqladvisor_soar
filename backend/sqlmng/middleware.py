from django.shortcuts import render,HttpResponse,redirect,HttpResponseRedirect

#try:

from django.utils.deprecation import MiddlewareMixin  # Django 1.10.x
#except ImportError:
#    MiddlewareMixin = object  # Django 1.4.x - Django 1.9.x

class SimpleMiddleware(MiddlewareMixin):
    def process_request(self, request):

        #if request.path != '/login/' and request.path != '/Web/CheckCode/':
        #    if  request.session.get('user',None):
        #        pass
        #    else:
    return HttpResponseRedirect('http://www.baidu.com/')