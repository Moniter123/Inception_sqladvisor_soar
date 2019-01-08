# -*- coding:utf-8 -*-
from django.contrib.auth.models import Group, Permission
from collections import OrderedDict
from django.forms.models import model_to_dict
from rest_framework import serializers
from .models import *

class SlowLogSerializer(serializers.ModelSerializer):

    class Meta:
        model = SlowLog
        fields = '__all__'
class SlowRecordSerializer(serializers.ModelSerializer):

    class Meta:
        model = SlowRecord
        fields = '__all__'
class SlowLogOrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = SlowLogOrder
        fields = '__all__'
class SlowLogCommentSerializer(serializers.ModelSerializer):

    class Meta:
        model = SlowLogComment
        fields = '__all__'