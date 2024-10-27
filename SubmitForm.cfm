<cfset app = new Application()>

<cfoutput>
    #app.insertTodo(form.title, form.desc, form.due_date)#
    <alert>Todo added successfully</alert>
    <a href="index.cfm">View Todos</a>
</cfoutput>