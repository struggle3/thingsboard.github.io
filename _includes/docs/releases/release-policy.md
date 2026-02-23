* TOC
{:toc}

本指南说明 ThingsBoard 的版本编号规则、各版本支持时长、何种升级需要停机，以及不同环境下应使用的 Docker 标签。 
面向平台管理员、SRE、DevOps 工程师和部署维护 ThingsBoard 的技术用户。

---

## ThingsBoard 版本规范

ThingsBoard 版本号反映每次发布引入的变更范围，遵循语义化版本原则，便于评估升级影响。
版本号由四部分组成：<span class="code-light">MAJOR.MINOR.MAINTENANCE.PATCH</span>。例如 <span class="code-light">4.2.1.0</span> 表示主版本 4、次版本 2、维护版本 1、补丁级别 0。

版本号随发布中变更等级递增。

<table style="width:75%">
  <thead>
    <tr>
      <td style="width: 20%"><b>级别</b></td>
      <td style="width: 60%"><b>变更类型</b></td>
      <td style="width: 20%"><b>是否需要升级脚本</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MAJOR</td>
      <td>破坏性变更、移除/弃用 API、重大迁移、新功能</td>
      <td>是</td>
    </tr>
    <tr>
      <td>MINOR</td>
      <td>向后兼容的新功能</td>
      <td>是</td>
    </tr>
    <tr>
      <td>MAINTENANCE</td>
      <td>缺陷修复、安全修复、<b>框架升级</b><br><small><b>注意：</b>通常需要升级脚本，但<u>并非总是</u>（如 Angular 18→20）</small></td>
      <td>可能需要</td>
    </tr>
    <tr>
      <td>PATCH</td>
      <td>不需要升级脚本的热修复（严重缺陷/安全修复；无环境/DB 变更）</td>
      <td>否</td>
    </tr>
  </tbody>
</table>

**示例**

<span class="code-light">4.2.0.0</span> — 4.2 LTS 首个发布

<span class="code-light">4.2.0.2</span> — 两次热修复后，在 <span class="code-light">4.2.0.x</span> 内升级无需升级脚本

<span class="code-light">4.2.1.0</span> — 首个维护版本；需要执行升级脚本

<span class="code-light">4.2.1.3</span> — 基于 <span class="code-light">4.2.1.0</span> 的热修复；在 <span class="code-light">4.2.1.x</span> 内可实现零停机升级

<span class="code-light">4.2.2.0</span> — 维护版本：含 Angular 升级（18 → 20）。无需 DB 脚本，但可能影响 UI。

## 生命周期与支持（版本支持时长）

ThingsBoard 为生产用户提供**长期支持（LTS）** 线路。使用 LTS 发布的客户可放心，其关键系统将得到保障并稳定运行。

<table style="width:75%">
  <thead>
    <tr>
      <td style="width: 20%"><b>发布类型</b></td>
      <td style="width: 30%"><b>说明</b></td>
      <td style="width: 30%"><b>支持时长</b></td>
      <td style="width: 20%"><b>典型频率</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>LTS</b></td>
      <td>每年发布；面向稳定、长期的生产使用。</td>
      <td>自 LTS GA 起 <b>18 个月</b>（如 4.2.0.0 发布日期）</td>
      <td>每年</td>
    </tr>
    <tr>
      <td><b>Standard</b></td>
      <td>LTS 之间的发布，含新功能。</td>
      <td>自 GA 日起 <b>6 个月</b></td>
      <td>每季度（Minor）</td>
    </tr>
  </tbody>
</table>

## 选择合适版本

**若用于生产环境：**

1. **优先选择处于活跃支持的 latest LTS 线路**。

2. 若要保持热修复更新，仅跟踪该线路’s **PATCH** 更新（MAINTENANCE 号相同，如 <span class="code-light">4.2.1.0</span> → <span class="code-light">4.2.1.3</span>）。

3. **规划维护窗口**，在需要时升级到新的 **MAINTENANCE** 发布（如 <span class="code-light">4.2.0.x</span> → <span class="code-light">4.2.1.0</span>）。

4. **MAINTENANCE 发布中的框架升级**（如 Angular 18 → 20）：
   * 我们保证**核心平台完整向后兼容**且**不要求任何升级脚本**。
   * 但依赖内部组件结构或 CSS 变量名的**自定义 UI 代码**（部件或自定义 CSS）**可能不可用**。
   * 可能影响**约 1%** 重度自定义用户。
   * **建议：** 在升级到此类 MAINTENANCE 发布前，务必在预发布环境测试自定义 UI。

## Docker Hub 标签策略

<table style="width:75%">
  <thead>
    <tr>
      <td style="width: 20%"><b>标签</b></td>
      <td style="width: 20%"><b>示例</b></td>
      <td style="width: 30%"><b>用途</b></td>
      <td style="width: 30%"><b>更新策略</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>M.m.P.p</td>
      <td>4.2.1.0</td>
      <td>生产环境</td>
      <td>不可变</td>
    </tr>
    <tr>
      <td>M.m.P</td>
      <td>4.2.1-latest</td>
      <td>自动安全补丁</td>
      <td>浮动（在 4.2.1.x 内）</td>
    </tr>
    <tr>
      <td>latest</td>
      <td>latest</td>
      <td>开发/测试（非 LTS）</td>
      <td>浮动（最新 master 发布）</td>
    </tr>
  </tbody>
</table>

**建议**

 - **生产环境：** 固定到完整不可变标签（如 4.2.1.0）。仅在更改标签时更新。

 - **自动安全热修复（零停机）：** 使用 4.2.1.1、4.2.1.2、… ，但不要跳到 4.2.2.0。

 - **生产环境避免使用 latest。** 可能含破坏性变更，且不受 LTS 策略保障。

## Compatibility & Deprecations

 - 在可行范围内，MAJOR 版本内保持 **API/行为兼容性**。Minor 发布可能弃用功能，但不应在没有迁移路径的情况下破坏现有集成。

 - **弃用策略：** Minor 发布中标记为弃用的功能，至少会保留到下一个 Minor 后才移除（或在可能时通过 feature flag 控制）。弃用与移除均会在 Release Notes 中说明。