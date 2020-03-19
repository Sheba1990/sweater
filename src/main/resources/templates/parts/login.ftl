<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            User Name:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="text"
                   name="username" value="<#if user??>${user.username}</#if>"
                   class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   placeholder="User Name"/>
            <#if usernameError??>
            <div class="invalid-feedback">
                ${usernameError}
            </div>
            </#if>
        </div>
    </div>

    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Password:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="password"
                   name="password"
                   class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   placeholder="Password"/>
            <#if passwordError??>
            <div class="invalid-feedback">
                ${passwordError}
            </div>
            </#if>
        </div>
    </div>

    <#if isRegisterForm><!-- условие: если это форма регистрации, то надо ещё вводить email для регистрации -->
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Password:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="password"
                   name="password2"
                   class="form-control ${(password2Error??)?string('is-invalid', '')}"
                   placeholder="Retype password"/>
            <#if password2Error??>
            <div class="invalid-feedback">
                ${password2Error}
            </div>
            </#if>
        </div>
    </div>
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Email:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="email"
                   name="email" value="<#if user??>${user.email}</#if>"
                   class="form-control ${(emailError??)?string('is-invalid', '')}"
                   placeholder="some@some.com"/>
            <#if emailError??>
            <div class="invalid-feedback">
                ${emailError}
            </div>
            </#if>
        </div>
    </div>
    </#if>

    <input type="hidden" name="_csrf" value="${_csrf.token}" />

    <#if isRegisterForm><!-- условие: если это форма рагистрации -->
    <button class="btn btn-primary" type="submit"><!-- то добавляем кнопку Sign up(зарегистрироваться) -->
            Sign up<!-- то Sign up(зарегистрироваться) -->
    </button>
    </#if>
    <#if !isRegisterForm><!-- условие: либо же, если это не форма рагистрации -->
        <a href="/registration"><!-- то добавляется URL ссылка на форму регистрации -->
            Add new user
        </a>
        <button class="btn btn-primary ml-2" type="submit"><!-- и добавляем кнопку входа, ml-2 отступ вправо -->
            Sign in<!-- то Log in(войти) -->
        </button>
    </#if>
</form>
</#macro>


<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-primary" type="submit"/>
    Sign out<!-- Log out(выйти) -->
    </button>
</form>
</#macro>