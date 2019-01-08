#coding=utf-8
from django.conf.urls import include, url
from rest_framework.routers import DefaultRouter

from .views import *

router = DefaultRouter()
router.register(r'(sloworderlist|detail)', SlowLogOrderViewSet, base_name='SlowLogOrderViewSet')
router.register(r'slowmyorderlist', SlowLogMyOrderViewSet, base_name='SlowLogMyOrderViewSet')
router.register(r'slowcommentlist', SlowLogOrderCommentViewSet, base_name='SlowLogOrderCommentViewSet')
router.register(r'slowloglist', SlowLogViewSet, base_name='SlowLogViewSet')

urlpatterns = [
 	url(r'^', include(router.urls)),
    url(r'^slowrecordlist$', SlowRecordViewSet.list),
    url(r'^slowlog/update$', SlowLogOrderViewSet.update),
    url(r'^slowlog/users$', SlowLogViewSet.maxinfo),
]