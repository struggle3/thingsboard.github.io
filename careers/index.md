---
layout: careers
title: 招聘
notitle: "true"
description: ThingsBoard 招聘
---

## 招聘
## 欢迎聪明、善于沟通的您加入我们在基辅办公室的团队。

<hr>
<div id="carsGrid">
{% for career in site.careers %}
  <a class="cars-box" href="{{ career.url }}">
  <div><h3>{{ career.position }}</h3>
  <h5>{{ career.tag }}</h5></div>
  <h5 class="secondPriority">{{ career.location }}</h5>
  </a>
{% endfor %}
</div>

<div id="technology">
<object data="/images/careers/angular.svg"></object>
<object data="/images/careers/spring.svg"></object>
<object data="/images/careers/java.svg"></object>
<object data="/images/careers/typescript.svg"></object>
<object data="/images/careers/kafka.svg"></object>
<object data="/images/careers/redis.svg"></object>
<object data="/images/careers/cassandra.svg"></object>
<object data="/images/careers/postgresql.svg"></object>
<object data="/images/careers/docker.svg"></object>
<object data="/images/careers/kubernets.svg"></object>
<object data="/images/careers/github.svg"></object>
<object data="/images/careers/aws.svg"></object>
<object data="/images/careers/azure.svg"></object>
<object data="/images/careers/google-cloud.svg"></object>
</div>

<div id="about">
<p class="title">关于我们：</p>
<h5>ThingsBoard, Inc. 是一家于 2016 年成立的美国公司，研发中心位于乌克兰基辅。我们是 ThingsBoard 开源 IoT 平台的主要贡献者和维护者。<br>
<br>我们提供并持续改进可扩展、稳定且经济实惠的 IoT 平台，大幅缩短改变生活的 IoT 解决方案的上线时间。我们也帮助企业在 ThingsBoard 基础上打造出色的 IoT 产品。</h5>
</div>

<h2>我们的工作方式：</h2>
<div id="advanGrid">
    <div>
      <img class="advanImg" src="/images/careers/schedule_icon.svg" alt="schedule icon">
      <h5>舒适灵活的工作时间</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/support_icon.svg" alt="support icon">
      <h5>高素质团队，无官僚作风</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/target_icon.svg" alt="target icon">
      <h5>职业发展机会与定期薪资评估</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/vacation_icon.svg" alt="vacation icon">
      <h5>团建、公司活动、带薪年假与病假</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/sweet_icon.svg" alt="sweet icon">
      <h5>无限量饮料、水果与零食</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/english_icon.svg" alt="english icon">
      <h5>免费英语课程</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/medical_icon.svg" alt="medical icon">
      <h5>医疗保险</h5>
    </div>
</div>
