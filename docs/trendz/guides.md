---
layout: docwithnav-trendz
assignees:
  - vparomskiy
title: Trendz Analytics 指南
description: Trendz Analytics 指南与教程
---
{% assign guides = site.data.trendz.guides-list %}
<div class="guides">
    <p>浏览我们关于使用数据分忻实现各种IoT用例的分步指南。学习如何利用Trendz Analytics提取洞察、优化运营并支撑决策。发现预测性维护、能源管理、 入住率追踪、异常检测等实用解决方案。</p>
    {% for guide in guides %}
    <div class="guides-block">
        <div class="guides-title-panel">
            <div class="guides-text">
                <p class="guides-title">
                    {{ guide.title }}
                </p>
                <p class="guides-subtitle">
                    {{ guide.subtitle }}
                </p>
            </div>
        </div>
        <ul class="guides-list">
            {% assign items = guide.section %}
            {% for item in items %}
            <li class="guide-container wide">
                <a href="{{ item.path }}">
                    <div class="guide-text">
                        <p class="guide-title">
                            {{ item.title }}
                        </p>
                        <p class="guide-subtitle">
                            {{ item.subtitle }}
                        </p>
                        <p class="guide-keywords">
                            {{ item.keywords }}
                        </p>
                    </div>
                </a>
            </li>
            {% endfor %}
        </ul>
    </div>
    {% endfor %}
</div>
