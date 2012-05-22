class Logger { 
    void log(String msg) {
        println "> $msg"
    }
}

myList = [1,2,3]
List.mixin(Logger)
myList.log('I log you')