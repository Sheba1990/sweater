<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            User Name:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="text" name="username" class="form-control" placeholder="User Name"/>
        </div>
    </div>

    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Password:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>

    <input type="hidden" name="_csrf" value="${_csrf.token}" />

    <#if isRegisterForm><!-- условие: если это форма рагистрации -->
    <button class="btn btn-primary" type="submit"><!-- то добавляем кнопку Sign up(зарегистрироваться) -->
            Sign up<!-- то Sign up(зарегистрироваться) -->
    </button>
    <#else><!-- условие: либо же, если это не форма рагистрации -->
        <a href="/registration"><!-- то добавляется URL ссылка на форму регистрации -->
            Add new user
        </a>
        <button class="btn btn-primary ml-2" type="submit"><!-- и добавляем кнопку входа, ml-2 отступ вправо -->
            Log in<!-- то Log in(войти) -->
        </button>
    </#if>
</form>
</#macro>


<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-primary" type="submit"/>
    Log out<!-- Log out(выйти) -->
    </button>
</form>
</#macro>