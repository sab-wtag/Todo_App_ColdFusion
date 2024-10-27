<cfset app = new Application()>
<cfset res = app.fetchTodo(url.id)>

<cfoutput query="res">
    <form action="updateTodo.cfm" method="POST">
        <input type="hidden" name="id" value="#res.id#"> 
        <input type="text" name="title" value="#res.title#">
        <input type="text" name="description" value="#res.description#">
        <input type="date" name="due_date" value="#DateFormat(res.due_date, 'YYYY-MM-DD')#">
        <input type="checkbox" name="status" value="1" <cfif res.status>checked</cfif>>
        <button type="submit">Update TODO</button>
    </form>
</cfoutput>