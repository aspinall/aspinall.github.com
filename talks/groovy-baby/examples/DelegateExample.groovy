class Logger { 
    void log(String msg) {
        println "> $msg"
    }
}

class Bar {
    @Delegate Logger logger = new Logger()
}

bar = new Bar()
bar.log('Delegation... for the nation!')