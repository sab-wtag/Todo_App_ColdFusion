<cfset app = new Application()>
<cfset status = app.deleteTodo(url.id)>
<cfif status EQ true>
    <cfoutput>
        <alert>Todo deleted successfully.</alert>
    </cfoutput>
<cfelse>
    <cfoutput>
        <alert>Todo was not deleted! Error occured.</alert>
    </cfoutput>
</cfif>
    <a href="index.cfm">View Todos</a>