---
layout: docwithnav-mobile
title: ThingsBoard移动应用文档
description: ThingsBoard移动应用 - 您的IoT移动应用的起点
---

* TOC
{:toc}

ThingsBoard移动应用是一个基于[Flutter](https://flutter.dev/)的开源[项目](https://github.com/thingsboard/flutter_thingsboard_app)。
它允许您**以最少的编码工作**构建自己的IoT移动应用。

本文档可帮助您设置并运行第一个IoT移动应用，学习如何自定义应用并将其发布到Google Play或App Store。

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/mobile/getting-started/">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Getting started icon">
            <div class="feature-title">快速入门</div>
            <div class="feature-text">
                了解如何设置并运行您的第一个IoT移动应用。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/mobile/customization/">
            <img class="feature-logo" src="/images/feature-logo/configuration.svg" alt="Gear icon">
            <div class="feature-title">自定义应用</div>
            <div class="feature-text">
                了解如何在不修改代码的情况下自定义应用。
            </div>
        </a>
    </div>
    <div class="col-12 col-lg mb-4">
        <a class="feature-card" href="/docs/mobile/release/">
            <img class="feature-logo" src="/images/feature-logo/publish.svg" alt="Publish icon">
            <div class="feature-title">发布应用</div>
            <div class="feature-text">
                了解如何将应用发布到Google Play或App Store。
            </div>
        </a>
    </div>
</div>

## 兼容性表

Flutter ThingsBoard移动应用与ThingsBoard实例版本之间的兼容性表。

<table id="compatibility-table">
    <thead>
        <tr>
          <td style="width: 25%"><b>ThingsBoard版本</b></td><td style="width: 25%"><b>Flutter ThingsBoard移动应用</b></td><td style="width: 25%"><b>Dart ThingsBoard Client</b></td><td style="width: 25%"><b>Flutter版本</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>4.3.0+</td>
            <td>1.8.0</td>
            <td>4.1.0</td>
            <td>3.29.0</td>
        </tr>
         <tr>
            <td>4.0.0+</td>
            <td>1.7.0</td>
            <td>4.0.0</td>
            <td>3.29.0</td>
        </tr>
         <tr>
            <td>4.0.0</td>
            <td>1.6.0</td>
            <td>4.0.0</td>
            <td>3.24.4</td>
        </tr>
         <tr>
            <td>3.9.0</td>
            <td>1.5.0</td>
            <td>3.0.0</td>
            <td>3.24.4</td>
        </tr>
        <tr>
            <td>3.8.1</td>
            <td>1.4.0</td>
            <td>2.0.0</td>
            <td>3.24.4</td>
        </tr>
        <tr>
            <td>3.8.0+</td>
            <td>1.3.0</td>
            <td>1.3.0</td>
            <td>3.22.2</td>
        </tr>
        <tr>
            <td>3.6.3+</td>
            <td>1.1.0</td>
            <td>1.1.0</td>
            <td>3.16</td>
        </tr>      
        <tr>
            <td>3.6.2+</td>
            <td>1.0.8</td>
            <td>1.0.8</td>
            <td>3.16</td>
        </tr>
        <tr>
            <td>3.6.0+</td>
            <td>1.0.7</td>
            <td>1.0.7</td>
            <td>3.7</td>
        </tr>
        <tr>
            <td>3.5.0+</td>
            <td>1.0.6</td>
            <td>1.0.6</td>
            <td>3.7</td>
        </tr>
        <tr>
            <td>3.4.2+</td>
            <td>1.0.4</td>
            <td>1.0.4</td>
            <td>3.7</td>
        </tr>
        <tr>
            <td>3.4.0+</td>
            <td>1.0.3</td>
            <td>1.0.3</td>
            <td>3.7</td>
        </tr>
    </tbody>
</table>
