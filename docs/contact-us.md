---
layout: common
title: 联系我们
notitle: "true"
---
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('encyclopedia').style.backgroundColor = '#F4F8FE';
        const header = document.getElementsByTagName('header')[0];
        header.style.backgroundColor = '#F4F8FE';
        header.style.boxShadow = 'none';
        const contentEl = document.getElementById('content');
        contentEl.style.backgroundImage = "url('/images/contact-us-bg.svg')";
        contentEl.style.backgroundPosition = "center";
        contentEl.style.backgroundRepeat = "no-repeat";
        contentEl.style.backgroundSize = "contain";
    });

    function isValidEmailFormat(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$/;
        return emailRegex.test(email);
    }

    function clearErrorState(inputElement) {
        if (!inputElement) return;

        inputElement.classList.remove('invalid-input');
        inputElement.setAttribute('aria-invalid', 'false');
        inputElement.removeAttribute('aria-describedby');

        const parentLabel = inputElement.closest('label');
        let potentialErrorHint;


        if (parentLabel && parentLabel.nextElementSibling && parentLabel.nextElementSibling.classList.contains('error-message-hint')) {
            potentialErrorHint = parentLabel.nextElementSibling;
        } else {
            const formElementDiv = inputElement.closest('.form-element');
            if (formElementDiv) {
                 const hintsInDiv = formElementDiv.querySelectorAll('.error-message-hint');
                 hintsInDiv.forEach(hint => {
                     if (hint.previousElementSibling === parentLabel) {
                         potentialErrorHint = hint;
                     }
                 });
                 if (!potentialErrorHint && hintsInDiv.length > 0) {
                    if (inputElement.nextElementSibling && inputElement.nextElementSibling.classList.contains('error-message-hint')) {
                        potentialErrorHint = inputElement.nextElementSibling;
                    }
                 }
            }
        }

        if (potentialErrorHint && potentialErrorHint.classList.contains('error-message-hint')) {
            potentialErrorHint.remove();
        }
    }

    function setErrorState(inputElement, message) {
        if (!inputElement) return;

        clearErrorState(inputElement);

        inputElement.classList.add('invalid-input');
        inputElement.setAttribute('aria-invalid', 'true');

        const errorHintId = `error-hint-${inputElement.id || inputElement.name || 'element'}`;
        inputElement.setAttribute('aria-describedby', errorHintId);

        const errorMessageElement = document.createElement('p');
        errorMessageElement.className = 'error-message-hint';
        errorMessageElement.id = errorHintId;
        errorMessageElement.textContent = message;
        errorMessageElement.setAttribute('role', 'alert');

        const parentLabel = inputElement.closest('label');
        if (parentLabel) {
            parentLabel.insertAdjacentElement('afterend', errorMessageElement);
        }
    }

    function validateContactForm(form) {
        let isValid = true;
        const fieldsToValidate = [
            { name: 'firstName', prettyName: '名', type: 'text', id: 'firstName' },
            { name: 'lastName', prettyName: '姓', type: 'text', id: 'lastName' },
            { name: 'email', prettyName: '电子邮箱', type: 'email', id: 'email' },
            { name: 'company', prettyName: '公司', type: 'text', id: 'company' },
            { name: 'message', prettyName: '留言', type: 'textarea', id: 'message' }
        ];

        fieldsToValidate.forEach(fieldSpec => {
            const inputElement = form.elements[fieldSpec.name];
            if (inputElement) {
                clearErrorState(inputElement);
            }
        });

        fieldsToValidate.forEach((fieldSpec) => {
            const inputElement = form.elements[fieldSpec.name];
            const value = inputElement.value.trim();
            let errorMessageText = '';

            if (value === '') {
                errorMessageText = `${fieldSpec.prettyName}为必填项。`;
            } else if (fieldSpec.type === 'email' && !isValidEmailFormat(value)) {
                errorMessageText = `请输入有效的${fieldSpec.prettyName}。`;
            }

            if (errorMessageText) {
                setErrorState(inputElement, errorMessageText);
                isValid = false;
            }
        });

        if (!isValid) {
            const firstInvalidField = form.querySelector('.invalid-input');
            if (firstInvalidField) {
                firstInvalidField.focus();
            }
        }
        return isValid;
    }


    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('ContactUs');

        const fieldsToWatchForInput = [
            'firstName', 'lastName', 'email', 'company', 'message'
        ];

        fieldsToWatchForInput.forEach(fieldName => {
            const inputElement = form.elements[fieldName];
            if (inputElement) {
                inputElement.addEventListener('input', function() {
                    if (this.classList.contains('invalid-input')) {
                        clearErrorState(this);
                    }
                });
            }
        });
    });
</script>
<form id="ContactUs" method="post" class="contact-form gtm_form" onsubmit="return validateContactForm(this)" novalidate>
    <h1 class="contact-us-title">联系我们</h1>
    <fieldset>
        <div class="form-section">
            <div class="form-element">
                <label for="firstName">
                   <input class="form-control" value="" placeholder="张" name="firstName" id="firstName" type="text" size="40" maxlength="50" aria-invalid="false">
                    <p>名</p>
                </label>
            </div>
            <div class="form-element">
                <label for="lastName">
                    <input class="form-control" value="" placeholder="三" name="lastName" id="lastName" type="text" size="40" maxlength="50" aria-invalid="false">
                    <p>姓</p>
                </label>
            </div>
            <div class="form-element">
                <label for="email">
                    <input class="form-control" value="" placeholder="zhangsan@example.com" name="email" id="email" type="email" size="40" maxlength="80" aria-invalid="false">
                    <p>电子邮箱</p>
                </label>
            </div>
            <div class="form-element">
                <label for="company">
                    <input class="form-control" value="" placeholder="我的公司" name="company" id="company" type="text" size="40" maxlength="80" aria-invalid="false">
                    <p>公司</p>
                </label>
            </div>
            <div class="form-element">
                <label for="subject" class="select-label">
                    <select class="form-control select" name="subject">
                        <option value="" disabled selected>选择主题</option>
                        <option value="Technical Support">技术支持</option>
                        <option value="ThingsBoard Products">ThingsBoard产品</option>
                        <option value="Private Cloud">私有云</option>
                        <option value="Deployment Options">部署方案</option>
                        <option value="Custom Development Service">定制开发服务</option>
                        <option value="Training">培训</option>
                        <option value="Professional Services">专业服务</option>
                        <option value="Partnership">合作伙伴</option>
                        <option value="Press or Analyst Inquiry">媒体或分析师咨询</option>
                        <option value="General Feedback">一般反馈</option>
                        <option value="TBMQ">TBMQ</option>
                        <option value="Other">其他</option>
                    </select>
                    <p>主题</p>
                </label>
            </div>
            <div class="form-element">
                <label for="message">
                    <textarea class="form-control text-area" placeholder="请输入留言内容" name="message" id="message" cols="50" rows="4" maxlength="3000" aria-invalid="false"></textarea>
                    <p class="text-area-label">留言</p>
                </label>
            </div>
            <input type="hidden" name="utm_source" id="utm_source">
            <input type="hidden" name="utm_medium" id="utm_medium">
            <input type="hidden" name="utm_campaign" id="utm_campaign">
            <input type="hidden" name="utm_term" id="utm_term">
            <input type="hidden" name="utm_content" id="utm_content-popup">
            <input type="hidden" name="client_id" id="client_id">
            <input type="hidden" name="fpr" id="fpr">
            <input type="hidden" name="tags" id="tags" value="product">
            <input type="hidden" name="form_id" id="form_id" value="contact_us">
            <input type="hidden" name="path" id="path" value="">
            <input type="hidden" name="_next" value="/docs/contact-us-thanks/">
            <input type="text" name="_gotcha" style="display:none">
        </div>
        <div class="submit-button-container">
             <input class="button" value="提交" type="submit">
        </div>
    </fieldset>
</form>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        let params = new URLSearchParams(window.location.search);
         if (params.has('pcorder')) {
            const titleEl = document.querySelector('.contact-us-title');
            titleEl.innerText = '获取您的私有IoT平台';
            titleEl.style.fontSize = '40px';
            document.querySelector('.select-label').parentElement.style.display = 'none';
        }
         if (params.has('tbmqorder')) {
            const titleEl = document.querySelector('.contact-us-title');
            titleEl.innerText = '获取您的私有MQTT Broker';
            titleEl.style.fontSize = '40px';
            document.querySelector('.select-label').parentElement.style.display = 'none';
        }
    });

    function getPath() {
        const url = new URL(window.location.href);
        return url.pathname;
    }

    function getURLParam(name) {
        const results = new RegExp('[?&]' + name + '=([^&#]*)').exec(window.location.href);
        return results ? decodeURIComponent(results[1].replace(/\+/g, ' ')) : null;
    }

    function populateUTMandClientIdFields() {
        var $form = $('.contact-form');
        if (!$form.length) return;

        const utmKeys = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content'];
        const utmData = {};

        utmKeys.forEach(function(key) {
            let value = getURLParam(key);
            if (value) {
                localStorage.setItem(key, value);
            } else {
                value = localStorage.getItem(key);
            }

            if (value) {
                value = decodeURIComponent(value);
                utmData[key] = value;
                $form.find('input[name="' + key + '"]').val(value);
            }
        });

        const path = getPath();
        $form.find('input[name="path"]').val(path);

        const gaCookie = document.cookie.split('; ').find(row => row.startsWith('_ga='));
        if (gaCookie) {
            const parts = gaCookie.split('.');
            if (parts.length >= 4) {
                const clientId = parts[2] + '.' + parts[3];
                utmData['client_id'] = clientId;
                $form.find('input[name="client_id"]').val(clientId);
            }
        }

        const fprValue = localStorage.getItem('fpr');
        if (fprValue) {
            utmData['fpr'] = fprValue;
            $form.find('input[name="fpr"]').val(fprValue);
        }

        window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({
            event: 'contact-us',
            ...utmData
        });
    }

    jqueryDefer(
        function () {
            $( document ).ready(function() {
                var $contactForm =  $('#ContactUs');
                $contactForm.attr('action', 'https://formspree.io/f/xrbnqnna');
                populateUTMandClientIdFields();
               /*  $('html, body').animate({
                            scrollTop: $('#contact-form').offset().top - 200
                          }, 0);*/
                 $contactForm.find('.form-element .form-control').addClass("input--empty");
                 $contactForm.find('.form-element .form-control').on('input', function() {
                      if( !$(this).val() ) {
                         $(this).addClass("input--empty");
                      } else {
                         $(this).removeClass("input--empty");
                      }
                 });
                 
                 $.urlParam = function (name) {
                     var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
                     return results ? results[1] : null;
                 };
                 const subjectValue = $.urlParam('subject');
                 const messageValue = $.urlParam('message');

                 if (subjectValue != undefined && subjectValue.trim().length > 0) {
                    $contactForm.find('select[name=subject]').val(decodeURIComponent(subjectValue));
                    $contactForm.find('select[name=subject]').removeClass("input--empty");
                 }
                 if (messageValue != undefined && messageValue.trim().length > 0) {
                    $contactForm.find('textarea').val(decodeURIComponent(messageValue));
                 }
            });
        }
    );

</script>
