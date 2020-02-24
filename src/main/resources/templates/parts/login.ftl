<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label"> User Name: </label>
        <div class="col-sm-6">
            <input type="text" name="username" class="form-control" placeholder="User Name"/>
        </div>
    </div>

    <div class="form-group row">
    <label class="col-sm-2 col-form-label"> Password: </label>
        <div class="col-sm-6">
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>

    <input type="hidden" name="_csrf" value="${_csrf.token}" />

    <#if !isRegisterForm> <!-- условие: если это не форма регистрации -->
        <a href="/registration">Add new user</a><!-- то добавляется URL ссылка на форму регистрации -->
    </#if>

    <button class="btn btn-primary" type="submit"><!-- добавляем кнопку -->
        <#if isRegisterForm><!-- условие: если это форма рагистрации -->
            Create<!-- то Create -->
        <#else><!-- условие: если это не форма рагистрации -->
            Sign In<!-- то Sign In -->
        </#if>
    </button>
</form>
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-primary" type="submit"/>Sign Out</button>
</form>
</#macro>