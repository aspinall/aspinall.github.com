cool = {
    println "Closures are cool!"
}

def doSomething(Closure something) {
    something()
}

doSomething(cool)