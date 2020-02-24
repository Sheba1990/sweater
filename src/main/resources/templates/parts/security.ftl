<#assign
<!-- оперирует контекстом SPRING_SECURITY -->
known = Session.SPRING_SECURITY_CONTEXT??<!-- ?? определяют что это тип boolean -->
>

<#if known><!-- условие: если из контекста SPRING_SECURITY пользователь известен -->
   <#assign
           <!-- это значение определяет пользователя из базы данных -->
           user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
           name = user.getUsername()<!-- получаем имя пользователя -->
           isAdmin = user.isAdmin()<!-- и проверяем через метод isAdmin, является ли пользователь админом -->
   >
<#else><!-- условие: если из контекста SPRING_SECURITY пользователь неизвестен -->
   <#assign
           name = "" <!-- то имя пользователя Unknown User -->
           isAdmin = false<!-- и устанавливаем значение метода isAdmin на false -->
   >
</#if>