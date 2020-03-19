<#import "parts/common.ftl" as c>

<@c.page>
<h5>${username}</h5>
${message?ifExists}
<form method="post">
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Password:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>
    <div class="form-group row"><!-- блок с формой группы и отдельная строка -->
        <label class="col-sm-2 col-form-label"><!-- col-sm-2 col-form-label указывает ширину поля в 2 колонки -->
            Email:
        </label>
        <div class="col-sm-6"><!-- col-sm-6 указывает ширину для поля ввода в 6 колонок -->
            <input type="email" name="email" class="form-control" placeholder="some@some.com" value="${email!''}"/>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-primary" type="submit">
        Save
    </button>
</form>
</@c.page>