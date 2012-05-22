class Logger { 
    void log(String msg) {
        println "> $msg"
    }
}

class Foo { 
    static {
        Foo.class.mixin(Logger) 
    }
}

foo = new Foo()
foo.log('Look Ma... I got me a log method!')
