<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger" role="alert">
            <div>
                ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
            </div>
        </div>
    </#if>
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            <div>
                ${message}
            </div>
        </div>
    </#if>
    <@l.login "/login" false/>
</@c.page>