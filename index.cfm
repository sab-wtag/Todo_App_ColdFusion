<cfset app = new Application()>
<cfset res = app.viewTodos()>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Todo App</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
  <link rel="stylesheet" href="globalStyles.css">
</head>
<body>
  <header>
    <h1>Todo App</h1>
  </header>

  <table>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th>Due Date</th>
      <th>Status</th>
      <th colspan="2" style="text-align:center">Actions</th>
    </tr>

    <cfloop from="1" to="#res.recordCount#" index="i">
      <cfoutput>
        <tr>
          <td>#res.title[i]#</td>
          <td>#res.description[i]#</td>
          <td>#dateFormat(res.due_date[i], 'dd/mm/yyyy')#</td>
          <td>#res.status[i]#</td>
          <td>
            <button>
              <a href="./editTodo.cfm?id=#id=res.id[i]#">
                Update
              </a>
            </button>
          </td>
          <td>
            <button>
              <a href="./deleteTodo.cfm?id=#id=res.id[i]#">
                Delete
              </a>
            </button>
          </td>
        </tr>
      </cfoutput>
    </cfloop>
  </table>

  <form action="SubmitForm.cfm" method="POST">
    <input type="text" name="title" placeholder="Title">
    <input type="text" name="desc" placeholder="Description">
    <input type="date" name="due_date">
    <button type="submit">Add Todo</button>
  </form>

  <footer>
    <p>&copy; 2024 Todo App. All rights reserved.</p>
  </footer>
</body>
</html>
