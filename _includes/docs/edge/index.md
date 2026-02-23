{% if docsPrefix == 'pe/' %}
{% assign platformName = '边缘计算插件' %}
{% else %}
{% assign platformName = '开源 IoT 边缘计算' %}
{% endif %}

{% if docsPrefix != 'pe/' %}
<div class="ce-banner" id="ceBanner">
  <span>需要白标或高级功能？ <a href="/docs/pe/edge/" target="_blank">查看 Edge 专业版文档 →</a></span>
  <button class="banner-close" aria-label="关闭横幅">×</button>
</div>
{% endif %}

<ul class="benefits-list">
  <li>设备部署在网络不稳定或成本较高的场景</li>
  <li>需要亚秒级响应，云端往返无法满足</li>
  <li>本地运维需要仪表板和控制在无网环境下可用</li>
  <li>希望在上传云端前过滤或聚合数据</li>
</ul>

<p class="learn-more">
  了解 Edge 如何实现离线运行、本地告警与数据同步 → <a href="/docs/{{docsPrefix}}edge/getting-started-guides/what-is-edge/" target="_blank">什么是 ThingsBoard Edge？</a>
</p>

<h2>IoT 边缘计算文档与指南</h2>

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/getting-started/" target="_blank">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="入门图标">
            <h3 class="feature-title">快速入门</h3>
            <div class="feature-text">
                搭建首个 Edge 实例并连接设备。约需 15–30 分钟。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/user-guide/install/{{docsPrefix}}edge/installation-options/" target="_blank">
            <img class="feature-logo" src="/images/feature-logo/install.svg" alt="安装图标">
            <h3 class="feature-title">安装</h3>
            <div class="feature-text">
                支持 Docker、Ubuntu、CentOS、Windows 或 Raspberry Pi 部署。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/use-cases/overview/" target="_blank">
            <img class="feature-logo" src="/images/feature-logo/tutorials.svg" alt="教程图标">
            <h3 class="feature-title">Edge 使用场景</h3>
            <div class="feature-text">
                部署场景、流量优化及本地数据处理。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/faq/" target="_blank">
            <img class="feature-logo" src="/images/feature-logo/faq.svg" alt="问号图标">
            <h3 class="feature-title">常见问题</h3>
            <div class="feature-text">
                关于 Edge 能力、限制和配置的常见问题。
            </div>
        </a>
    </div>
</div>

{% if docsPrefix != 'pe/' %}
<div class="commercial-banner">
  <h2>需要更多能力？</h2>
  <p>从预置解决方案模板起步，通过 30+ 集成协议连接传统设备，并可将一切白标为自有产品。</p>
  <div class="banner-actions">
    <a href="/docs/contact-us/?subject=ThingsBoard%20Products" class="btn-primary" target="_blank">联系我们</a>
  </div>
</div>
{% endif %}

<script>
(function() {
  'use strict';
  
  function closeBanner() {
    const banner = document.getElementById('ceBanner');
    if (!banner) return;
    
    banner.style.opacity = '0';
    banner.style.transition = 'opacity 0.3s ease';
    
    setTimeout(() => {
      banner.style.display = 'none';
    }, 300);
    
    try {
      sessionStorage.setItem('ceBannerClosed', 'true');
    } catch (e) {
      console.warn('Could not save banner state:', e);
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    const banner = document.getElementById('ceBanner');
    if (!banner) return;
    
    try {
      if (sessionStorage.getItem('ceBannerClosed') === 'true') {
        banner.style.display = 'none';
        return;
      }
    } catch (e) {
      console.warn('Could not read banner state:', e);
    }
    
    const closeBtn = banner.querySelector('.banner-close');
    if (closeBtn) {
      closeBtn.addEventListener('click', closeBanner);
    }
  });
})();
</script>

<style>
/* Top banner */
.ce-banner {
  position: relative;
  top: -10px; 
  background: linear-gradient(135deg, #f8fbff 0%, #ffffff 100%);
  border: 1px solid #e3f2fd;
  border-left: 4px solid #1976D2;
  border-radius: 8px;
  padding: 8px 12px;
  margin: 0 0 0 0;
  font-size: 13px;
  color: #424242;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.ce-banner a {
  color: #1976D2;
  text-decoration: none;
  font-weight: 500;
}

.ce-banner a:hover {
  text-decoration: underline;
}

.banner-close {
  background: none;
  border: none;
  font-size: 20px; 
  color: #757575;
  cursor: pointer;
  padding: 0;
  width: 20px; 
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: color 0.2s ease;
  flex-shrink: 0;
  line-height: 1;
}

.banner-close:hover {
  color: #1976D2;
}

.banner-close:focus {
  outline: 2px solid #1976D2;
  outline-offset: 2px;
}

/* Lead text */
.lead-text {
  font-size: 16px;
  line-height: 1.6;
  color: #424242;
}

/* Benefits list */
.benefits-list {
  padding: 0;
}

.benefits-list li {
  position: relative;
  padding-left: 24px;
  margin-bottom: 8px;
  font-size: 15px;
  line-height: 1.5;
  color: #424242;
}

/* Learn more link */
.learn-more {
  font-size: 15px;
  color: #424242;
  margin: 0 0 20px 0;
}

.learn-more a {
{% if docsPrefix != 'pe/' %}
  color: #1976D2;
{% else %}
  color: #009688;
{% endif %}
  text-decoration: none;
  font-weight: 500;
}

.learn-more a:hover {
  text-decoration: underline;
}

/* Section heading */
h2 {
  font-size: 24px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 20px 0 24px 0;
}
/* Cards */

.doc-features .feature-card {
  display: block;
  text-decoration: none;
  color: inherit;
  height: 100%;
  padding: 16px;
}

.doc-features .feature-title {
  font-size: 18px !important;
  font-weight: 400;
  color: #1a1a1a;
  margin: 0 0 4px 0 !important;
}

/* Commercial banner */
.commercial-banner {
  background: linear-gradient(135deg, #f8fbff 0%, #ffffff 100%);
  border: 1px solid #e3f2fd;
  border-left: 4px solid #1976D2;
  border-radius: 8px;
  padding: 15px;
  margin: 5px 0;
}

.commercial-banner h2 {
  font-size: 24px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0 0 12px 0;
}

.commercial-banner p {
  font-size: 15px;
  line-height: 1.6;
  color: #424242;
  margin: 0 0 20px 0;
}

.banner-actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.btn-secondary,
.btn-primary {
  display: inline-block;
  padding: 12px 24px;
  font-size: 15px;
  font-weight: 500;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.2s ease;
  border: none;
  cursor: pointer;
}

.btn-secondary {
  color: #1976D2;
  background: white;
  border: 1px solid #1976D2;
}

.btn-secondary:hover {
  background: #e3f2fd;
}

.btn-primary {
  color: white;
  background: #1976D2;
  border: 1px solid #1976D2;
}

.btn-primary:hover {
  background: #1565C0;
  box-shadow: 0 4px 12px rgba(25, 118, 210, 0.3);
}

/* Responsive */
@media (max-width: 768px) {
  h1 {
    font-size: 28px;
  }
  
  h2 {
    font-size: 22px;
  }
  
  .commercial-banner {
    padding: 24px;
  }
}
</style>