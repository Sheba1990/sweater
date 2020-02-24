<#include "security.ftl"><!-- включаем сюда шаблое security.ftl -->
<#import "login.ftl" as l><!-- включаем сюда шаблое login.ftl -->

<!-- это форма навигационной панели -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <!-- navbar-expand-lg значит что размер навигационной панели форматируется на основании размера экрана -->
    <!-- navbar-light bg-light описывает цветовую схему навигационной панели -->
    <a class="navbar-brand" href="/">
        <div class="text-primary">
            Sweater
        </div>
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto"><!-- автоматически генерируемое меню -->
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a><!-- это навигационная ссылка кнопки Home -->
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/main">Messages</a><!-- это навигационная ссылка кнопки Messages -->
            </li>
            <#if isAdmin><!-- если пользователь с правами ADMIN то у него есть доступ к списку пользователей -->
            <li class="nav-item">
                <a class="nav-link" href="/user">User list</a><!-- это навигационная ссылка кнопки User list -->
            </li>
            </#if>
        </ul>
        <div class="navbar-text mr-3"><!-- этот блок добавляет текст с именем пользователя, mr-3 добавляет отступ справа -->
            ${name}<!-- имя пользователя -->
        </div>
        <@l.logout /><!-- рядом с именем пользователя отображается кнопка Log Out -->
    </div>
</nav>