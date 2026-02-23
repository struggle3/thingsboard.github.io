---
layout: docwithnav-pe
title: 使用 ThingsBoard MCP server 实现 AI 驱动的洞察
description: 探索 ThingsBoard MCP server 如何为更智能的 IoT 数据管理提供 AI 驱动的洞察

claude-thingsboard-tools:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/claude-thingsboard-tools.png
        title: 'Claude Desktop 中可见的 ThingsBoard MCP 工具。'

claude-get-devices-query:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/claude-get-devices-query.png
        title: 'Claude Desktop 查询获取类型为「空气质量传感器」的设备。'

thingsboard-devices-list:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/thingsboard-devices-list-1-pe.png
        title: 'ThingsBoard 设备列表展示空气质量传感器设备。'

claude-generate-data-query:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/claude-generate-data-query.png
        title: 'Claude Desktop 查询生成 AQI 传感器示例数据。'

thingsboard-generated-data:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/thingsboard-generated-data-1-pe.png
        title: 'MCP 生成的 AQI 传感器时序数据已自动添加到 ThingsBoard。'

claude-analyze-anomaly:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/claude-analyze-anomaly.png
        title: 'Claude Desktop 查询以分析 AQI 传感器数据的异常。'

claude-analyze-result:
    0:
        image: /images/samples/analytics/mcp-server-ai-insights/claude-analyze-result.png
        title: 'Claude Desktop 表格显示异常检测结果。'
---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include /docs/samples/analytics/mcp-server-ai-insights.md %}
