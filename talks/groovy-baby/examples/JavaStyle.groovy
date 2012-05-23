myList = [1,2,3,4,5]

class Chooser {
    static def pickOneFrom(list) {
        list[new Random().nextInt(list.size())]
    }
}

Chooser.pickOneFrom(myList)