component{
    this.datasources = loadDatasources();
    public boolean function connectToDB(){
        var isConnected = false;
        try {
            queryExecute("SELECT * from todo_table;", {}, {datasource = "mariadbDNS"});
            isConnected = true;
        }
        catch(any e){
            isConnected = false;
            logError("Error connecting to database: " & e.message);
            writeOutput("Error : #e.message#<br>");
        }
        return isConnected;
    }

    public void function insertTodo(required string title, string description = "", date due_date = now()) {
        if (connectToDB()) {
            try {
                queryExecute("
                    INSERT INTO todo_table (title, description, due_date, status)
                    VALUES (:title, :description, :due_date, false)
                ", {
                    title = title,
                    description = description,
                    due_date = due_date
                }, { datasource = "mariadbDNS" });
            } catch (any e) {
                logError("Error inserting todo: " & e.message);
                writeOutput("Error inserting todo: #e.message#<br>");
            }
        }
    }

    public query function viewTodos(){
        if(connectToDB()){
            try {
                var qItems = queryExecute("SELECT * from todo_table;", {}, {datasource = "mariadbDNS"});
                return qItems;
            } catch (any e) {
                logError("Error viewing todos: " & e.message);
                return e.message;
            }
        }
    }

    public query function fetchTodo(required numeric taskId) {
        if (connectToDB()) {
            try {
                return queryExecute(
                    sql: "SELECT * from todo_table WHERE id = :id;",
                    params: {id: arguments.taskId},
                    options: {datasource: "mariadbDNS"}
                );
            } catch (any e) {
                logError("Error fetching todos: <br>#e.message#");
                return e.message;
            }
        }
    }

    public boolean function updateTodo(required numeric id, string title, string description, date due_date, boolean status=0){
        if(connectToDB()){
            try {
                queryExecute(sql: "UPDATE todo_table SET title=:title, description=:description, due_date=:due_date,            status=:status WHERE id=:id;",
                            params: {
                                title: arguments.title,
                                description: arguments.description,
                                due_date: arguments.due_date,
                                status: arguments.status,
                                id: arguments.id,
                            },
                            options: {datasource = "mariadbDNS"});
                return true;
            }
            catch(any e){
                logError("Error updating todo: #e.message#");
                return false;
            }
        }
    }

    public boolean function deleteTodo(required numeric taskId){
        if(connectToDB()){
            try {
                queryExecute(
                    sql: "DELETE FROM todo_table WHERE id=:id",
                    params: {id: arguments.taskId},
                    options: {datasource: "mariadbDNS"}
                )
                return true;
            }
            catch(any e){
                logError("Error deleting todos: #e.message#");
                return false;
            }
        }
    }

    private void function logError(required string message) {
        var logFilePath = expandPath('/debug.log');
        var logMessage = "=============================Error=============================" & chr(10) & message & chr(10) & chr(10) & chr(10);

        try {
            fileAppend(logFilePath, logMessage);
        } catch(any e){
            writeOutput("Error writing to log file: #e.message#");
        }

        writeLog(type = "error", file = "database-connection", text = message);
    }

    private struct function loadDatasources() {
        var datasourcesFile = expandPath('/datasources.json');
        var datasources = deserializeJSON(fileRead(datasourcesFile));
        return datasources;
    }
}