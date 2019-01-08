from __future__ import unicode_literals
from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
import json
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from utils.baseviews import MaxSizePagination, BaseView
from rest_framework import status
from utils.permissions import IsSuperUser
from account.models import *
from account.serializers import *
from .models import *
from .serializers import *
from utils.baseviews import ReturnFormatMixin as res
import datetime
# Create your views here.
class SlowLogViewSet(BaseView):
	'''
	系统慢查询日志处理GET请求
	'''
	permission_classes = [IsSuperUser]
	search_fields = ['SQLText']
	def get_queryset(self):
		user_obj = self.request.user
		user_info = {}
		user_info['username'] = user_obj.username
		user_info['date_joined'] = user_obj.date_joined
		user_info['group'] = user_obj.groups.first().name if user_obj.groups.first() else None
		user_info['identity'] = 'superuser' if user_obj.is_superuser else user_obj.role
		return user_info
	def list(self,request, *args, **kwargs):
		sorttype = request.GET.get('sorttype')
		sortfield = request.GET.get('sortfield')
		if sortfield:
			if sorttype == 'asc':
				queryset = SlowLog.objects.all().order_by(sortfield)
			else:
				queryset = SlowLog.objects.all().order_by('-'+sortfield)
		else:
			queryset = SlowLog.objects.all().order_by('-id')
		dateranges = request.GET.get('daterange')
		if dateranges:
			queryset = queryset.filter(CreateTime__range = dateranges.split(','))
		searchfield = request.GET.get('search')
		if searchfield:
			queryset = queryset.filter(SQLText__icontains = searchfield)
		page = request.GET.get('page')
		pagesize = request.GET.get('pagesize')
		if pagesize:
			pagesize=pagesize
		else:
			pagesize=10
		paginator = Paginator(queryset, pagesize)
		try:
			if page:
				slowlog_list = paginator.page(page)
			else:
				slowlog_list = paginator.page(1)
		except PageNotAnInteger:
			slowlog_list = paginator.page(1)
		except EmptyPage:
			if int(page) > paginator.num_pages:
				slowlog_list = paginator.page(paginator.num_pages)
			else:
				slowlog_list = paginator.page(1)
		serializer = SlowLogSerializer(slowlog_list,many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'counts':int(paginator.count),'identity':"1" if request.user.is_superuser else "0"}),status=status.HTTP_200_OK)
	def getslowinfo(self,request, *args, **kwargs):
		slowid = request.GET.get('id')
		serializer = SlowLogSerializer(SlowLog.objects.filter(id = slowid),many=True)
		return HttpResponse(json.dumps(serializer.data),status=status.HTTP_200_OK)
	def maxinfo(request, *args, **kwargs):
		queryset = User.objects.all().order_by('-id')
		serializer = UserSerializer(queryset,many=True)
		return HttpResponse(json.dumps(serializer.data),status=status.HTTP_200_OK)
class SlowRecordViewSet(BaseView):
	'''
	系统慢查询记录GET请求
	'''
	permission_classes = [IsSuperUser]
	search_fields = ['SQLText']
	def list(request, *args, **kwargs):
		sqlid = request.GET.get('sqlid')
		sorttype = request.GET.get('sorttype')
		sortfield = request.GET.get('sortfield')
		if sortfield:
			if sorttype == 'asc':
				if sqlid:
					queryset = SlowRecord.objects.filter(SQLId=sqlid).order_by(sortfield)
				else:
					queryset = SlowRecord.objects.all().order_by(sortfield)
			else:
				if sqlid:
					queryset = SlowRecord.objects.filter(SQLId=sqlid).order_by('-'+sortfield)
				else:
					queryset = SlowRecord.objects.all().order_by('-'+sortfield)
		else:
			if sqlid:
				queryset = SlowRecord.objects.filter(SQLId=sqlid).order_by('-id')
			else:
				queryset = SlowRecord.objects.all().order_by('-id')
		dateranges = request.GET.get('daterange')
		if dateranges:
			queryset = queryset.filter(ExecutionStartTime__range = dateranges.split(','))
		searchfield = request.GET.get('search')
		if searchfield:
			queryset = queryset.filter(SQLText__icontains = searchfield)
		page = request.GET.get('page')
		pagesize = request.GET.get('pagesize')
		if pagesize:
			pagesize=pagesize
		else:
			pagesize=10
		paginator = Paginator(queryset, pagesize)
		try:
			if page:
				slowlog_list = paginator.page(page)
			else:
				slowlog_list = paginator.page(1)
		except PageNotAnInteger:
			slowlog_list = paginator.page(1)
		except EmptyPage:
			if int(page) > paginator.num_pages:
				slowlog_list = paginator.page(paginator.num_pages)
			else:
				slowlog_list = paginator.page(1)			
		serializer = SlowRecordSerializer(slowlog_list,many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'counts':int(paginator.count)}),status=status.HTTP_200_OK)
	def getslowinfo(request, *args, **kwargs):
		slowid = request.GET.get('id')
		serializer = SlowRecordSerializer(SlowRecord.objects.filter(id = slowid),many=True)
		return HttpResponse(json.dumps(serializer.data),status=status.HTTP_200_OK)

class DateEncoder(json.JSONEncoder):
	'''
	json序列化datetime
	'''
	def default(self,obj):
		if isinstance(obj,datetime.datetime):
			return obj.strftime('%Y-%m-%d %H:%M:%S')
		elif isinstance(obj,date):
			return obj.strftime("%Y-%m-%d")
		else:
			return json.JSONEncoder.default(self,obj)

class SlowLogOrderViewSet(BaseView):
	'''
	系统慢查询工单处理GET请求
	'''
	permission_classes = [IsSuperUser]
	search_fields = ['SQLText']
	def get_queryset(self):
		user_obj = self.request.user
		user_info = {}
		user_info['username'] = user_obj.username
		user_info['date_joined'] = user_obj.date_joined
		user_info['group'] = user_obj.groups.first().name if user_obj.groups.first() else None
		user_info['identity'] = 'superuser' if user_obj.is_superuser else user_obj.role
		return user_info
	def list(self,request, *args, **kwargs):
		sorttype = request.GET.get('sorttype')
		sortfield = request.GET.get('sortfield')
		if sortfield:
			if sorttype == 'asc':
				queryset = SlowLogOrder.objects.all().order_by(sortfield)
			else:
				queryset = SlowLogOrder.objects.all().order_by('-'+sortfield)
		else:
			queryset = SlowLogOrder.objects.all().order_by('-id')
		dateranges = request.GET.get('daterange')
		if dateranges:
			queryset = queryset.filter(CreateTime__range = dateranges.split(','))
		searchfield = request.GET.get('search')
		if searchfield:
			queryset = queryset.filter(SQLText__icontains = searchfield)
		page = request.GET.get('page')
		pagesize = request.GET.get('pagesize')
		if pagesize:
			pagesize=pagesize
		else:
			pagesize=10
		paginator = Paginator(queryset, pagesize)
		try:
			if page:
				slowlog_list = paginator.page(page)
			else:
				slowlog_list = paginator.page(1)
		except PageNotAnInteger:
			slowlog_list = paginator.page(1)
		except EmptyPage:
			if int(page) > paginator.num_pages:
				slowlog_list = paginator.page(paginator.num_pages)
			else:
				slowlog_list = paginator.page(1)
		serializer = SlowLogOrderSerializer(slowlog_list,many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'counts':int(paginator.count),'identity':"1" if request.user.is_superuser else "0",'username':request.user.username}),status=status.HTTP_200_OK)
	def retrieve(self,request, *args, **kwargs):
		slowid = request.GET.get('id')
		serializer = SlowLogOrderSerializer(SlowLogOrder.objects.filter(id = slowid),many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'identity':"1" if request.user.is_superuser else "0",'username':request.user.username}),status=status.HTTP_200_OK)
	def update(request, *args, **kwargs):
		slowstatus = request.GET.get('status')
		showid = request.GET.get('id')
		SlowLogOrder.objects.filter(id=showid).update(status=slowstatus)
		return HttpResponse(json.dumps({'status':201}),status=status.HTTP_200_OK)	
class SlowLogMyOrderViewSet(BaseView):
	'''
	系统慢查询工单处理GET请求
	'''
	permission_classes = [IsSuperUser]
	search_fields = ['SQLText']
	def get_queryset(self):
		user_obj = self.request.user
		user_info = {}
		user_info['username'] = user_obj.username
		user_info['date_joined'] = user_obj.date_joined
		user_info['group'] = user_obj.groups.first().name if user_obj.groups.first() else None
		user_info['identity'] = 'superuser' if user_obj.is_superuser else user_obj.role
		return user_info
	def list(self,request, *args, **kwargs):
		sorttype = request.GET.get('sorttype')
		sortfield = request.GET.get('sortfield')
		if sortfield:
			if sorttype == 'asc':
				queryset = SlowLogOrder.objects.all().order_by(sortfield)
			else:
				queryset = SlowLogOrder.objects.all().order_by('-'+sortfield)
		else:
			queryset = SlowLogOrder.objects.all().order_by('-id')
		dateranges = request.GET.get('daterange')
		if dateranges:
			queryset = queryset.filter(CreateTime__range = dateranges.split(','))
		searchfield = request.GET.get('search')
		if searchfield:
			queryset = queryset.filter(SQLText__icontains = searchfield)
		if request.user.username:
			queryset = queryset.filter(executor = request.user.username)
		page = request.GET.get('page')
		pagesize = request.GET.get('pagesize')
		if pagesize:
			pagesize=pagesize
		else:
			pagesize=10
		paginator = Paginator(queryset, pagesize)
		try:
			if page:
				slowlog_list = paginator.page(page)
			else:
				slowlog_list = paginator.page(1)
		except PageNotAnInteger:
			slowlog_list = paginator.page(1)
		except EmptyPage:
			if int(page) > paginator.num_pages:
				slowlog_list = paginator.page(paginator.num_pages)
			else:
				slowlog_list = paginator.page(1)
		serializer = SlowLogOrderSerializer(slowlog_list,many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'counts':int(paginator.count)}),status=status.HTTP_200_OK)
	def create(self, request, *args, **kwargs):
		request_data = request.data
		request_data['distributor']=request.user.username
		request_data['createtime'] = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
		request_data['status'] = 0 
		request_data['updatetime'] = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
		slowid = request_data['id']
		del request_data['id']
		serializer = SlowLogOrderSerializer(data=request_data)
		serializer.is_valid(raise_exception=True)
		serializer.save()
		SlowLog.objects.filter(id=slowid).update(slow_status=1)
		return HttpResponse(json.dumps({'status':201}),status=status.HTTP_200_OK)
class SlowLogOrderCommentViewSet(BaseView):
	'''
	系统慢查询工单回复GET请求
	'''
	permission_classes = [IsSuperUser]
	search_fields = ['SQLText']
	def get_queryset(self):
		user_obj = self.request.user
		user_info = {}
		user_info['username'] = user_obj.username
		user_info['date_joined'] = user_obj.date_joined
		user_info['group'] = user_obj.groups.first().name if user_obj.groups.first() else None
		user_info['identity'] = 'superuser' if user_obj.is_superuser else user_obj.role
		return user_info
	def list(self,request, *args, **kwargs):
		slowid = request.GET.get('id')
		if slowid:
			queryset = SlowLogComment.objects.all().filter(slowid=slowid).order_by('-id')
		else:
			queryset = SlowLogComment.objects.all().order_by('-id')
		page = request.GET.get('page')
		pagesize = request.GET.get('pagesize')
		if pagesize:
			pagesize=pagesize
		else:
			pagesize=10
		paginator = Paginator(queryset, pagesize)
		try:
			if page:
				slowlog_list = paginator.page(page)
			else:
				slowlog_list = paginator.page(1)
		except PageNotAnInteger:
			slowlog_list = paginator.page(1)
		except EmptyPage:
			if int(page) > paginator.num_pages:
				slowlog_list = paginator.page(paginator.num_pages)
			else:
				slowlog_list = paginator.page(1)
		serializer = SlowLogCommentSerializer(slowlog_list,many=True)
		return HttpResponse(json.dumps({'data':serializer.data,'counts':int(paginator.count)}),status=status.HTTP_200_OK)
	def create(self, request, *args, **kwargs):
		request_data = request.data
		request_data['slowid'] = request_data['id']
		del request_data['id']
		request_data['content']=request_data['replay']
		del request_data['replay']
		q_data = User.objects.get(username=request.user.username)
		request_data['commentor']=request.user.username
		request_data['email']=q_data.email
		request_data['createtime'] = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
		serializer = SlowLogCommentSerializer(data=request_data)
		serializer.is_valid(raise_exception=True)
		serializer.save()
		#SlowLog.objects.filter(id=slowid).update(slow_status=1)
		return HttpResponse(json.dumps({'status':201}),status=status.HTTP_200_OK)

