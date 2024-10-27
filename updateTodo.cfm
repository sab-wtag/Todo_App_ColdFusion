<cfset app = new Application()>
<cfif StructKeyExists(form, "status")>
    <cfset stat = app.updateTodo(form.id, form.title, form.description, form.due_date, form.status)>
<cfelse>
    <cfset stat = app.updateTodo(form.id, form.title, form.description, form.due_date)>
</cfif>
<cfif stat EQ true>
    <cfoutput>
        Your todo was updated succesfully
    </cfoutput>
    <cfelse>
    <cfoutput>
        Your todo was not updated! Error occured! <br>
    </cfoutput>
</cfif>

<a href="index.cfm">View Todos</a>