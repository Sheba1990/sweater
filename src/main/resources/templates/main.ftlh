<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="row mb-3">
        <div class="input-group">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" value="${filter?ifExists}" placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Search</button>
            </form>
        </div>
    </div>
    <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        Add new message
    </a>
    <div class="collapse" id="collapseExample">
        <div class="input-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" name="text" placeholder="Введите сообщение">
                </div>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" name="tag" placeholder="Тэг">
                </div>
                <div class="input-group mb-3">
                    <input type="file" name="file" class="form-control" id="inputGroupFile">
                    <label class="input-group-text" for="inputGroupFile02">
                        Choose file
                    </label>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="input-group mb-3">
                    <button type="submit" class="btn btn-primary">
                        Добавить
                    </button>
                </div>
            </form>
        </div>
    </div>
    <div class="row row-cols-1 row-cols-md-3 g-4 mt-1">
        <#list messages as message>
            <div class="col">
                <div class="card">
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <div class="card-body m-2">
                        <p class="card-text">${message.text}</p>
                        <h5 class="card-tittle">${message.tag}</h5>
                    </div>
                    <div class="card-footer text-muted">
                        ${message.authorName}
                    </div>
                </div>
            </div>
        <#else>
            No messages
        </#list>
    </div>
</@c.page>